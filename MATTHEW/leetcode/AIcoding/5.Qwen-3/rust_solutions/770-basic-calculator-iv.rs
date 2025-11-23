impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn basic_calculator_iv(expression: String, evalvars: Vec<String>, evalints: Vec<i32>) -> Vec<String> {
        let mut map = HashMap::new();
        for i in 0..evalvars.len() {
            map.insert(&evalvars[i], evalints[i]);
        }
        let tokens = Self::parse_expression(&expression);
        let mut stack = vec![];
        let mut current = None;
        let mut sign = 1;
        for token in tokens {
            match token {
                Token::Number(n) => {
                    if let Some(mut expr) = current {
                        expr.add_term(1, vec![n]);
                        current = Some(expr);
                    } else {
                        current = Some(Expression::new(vec![n]));
                    }
                },
                Token::Var(v) => {
                    if let Some(mut expr) = current {
                        expr.add_term(1, vec![v]);
                        current = Some(expr);
                    } else {
                        current = Some(Expression::new(vec![v]));
                    }
                },
                Token::Plus => {
                    sign = 1;
                },
                Token::Minus => {
                    sign = -1;
                },
                Token::LeftParen => {
                    stack.push(current);
                    stack.push(sign);
                    current = None;
                    sign = 1;
                },
                Token::RightParen => {
                    let s = stack.pop().unwrap();
                    let prev = stack.pop().unwrap();
                    let mut expr = current.unwrap();
                    expr = expr.multiply_by_sign(prev);
                    if let Some(mut prev_expr) = current {
                        prev_expr = prev_expr.add_term(s, vec![]);
                        prev_expr = prev_expr.add_term(1, vec![]);
                        current = Some(prev_expr);
                    } else {
                        current = Some(expr);
                    }
                },
                _ => {}
            }
        }
        let result = current.unwrap();
        let mut res = vec![];
        for term in result.terms {
            let mut parts = vec![];
            for var in &term.vars {
                if let Some(val) = map.get(var) {
                    parts.push(val.to_string());
                } else {
                    parts.push(var.clone());
                }
            }
            let coeff = term.coeff;
            if coeff != 0 {
                let mut part = coeff.to_string();
                for p in &parts {
                    part.push_str(&format!("*{}", p));
                }
                res.push(part);
            }
        }
        res.sort();
        res
    }

    fn parse_expression(s: &str) -> Vec<Token> {
        let mut tokens = vec![];
        let mut i = 0;
        while i < s.len() {
            let c = s.chars().nth(i).unwrap();
            if c.is_whitespace() {
                i += 1;
                continue;
            }
            if c == '+' || c == '-' || c == '(' || c == ')' {
                tokens.push(Token::from(c));
                i += 1;
                continue;
            }
            if c.is_digit(10) {
                let mut j = i;
                while j < s.len() && s.chars().nth(j).unwrap().is_digit(10) {
                    j += 1;
                }
                tokens.push(Token::Number(s[i..j].to_string()));
                i = j;
                continue;
            }
            if c.is_alphabetic() {
                let mut j = i;
                while j < s.len() && s.chars().nth(j).unwrap().is_alphabetic() {
                    j += 1;
                }
                tokens.push(Token::Var(s[i..j].to_string()));
                i = j;
                continue;
            }
            i += 1;
        }
        tokens
    }
}

#[derive(Clone, Debug, PartialEq)]
enum Token {
    Number(String),
    Var(String),
    Plus,
    Minus,
    LeftParen,
    RightParen,
}

impl Token {
    fn from(c: char) -> Self {
        match c {
            '+' => Self::Plus,
            '-' => Self::Minus,
            '(' => Self::LeftParen,
            ')' => Self::RightParen,
            _ => panic!(),
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
struct Expression {
    terms: Vec<Term>,
}

impl Expression {
    fn new(vars: Vec<String>) -> Self {
        Self { terms: vec![Term::new(1, vars)] }
    }

    fn add_term(&mut self, coeff: i32, vars: Vec<String>) {
        let mut found = false;
        for term in &mut self.terms {
            if term.vars == vars {
                term.coeff += coeff;
                found = true;
                break;
            }
        }
        if !found {
            self.terms.push(Term::new(coeff, vars));
        }
    }

    fn multiply_by_sign(&self, sign: i32) -> Self {
        let mut new_terms = vec![];
        for term in &self.terms {
            new_terms.push(Term::new(term.coeff * sign, term.vars.clone()));
        }
        Self { terms: new_terms }
    }

    fn add(&self, other: &Self) -> Self {
        let mut new_terms = self.terms.clone();
        for term in &other.terms {
            new_terms.push(term.clone());
        }
        Self { terms: new_terms }
    }
}

#[derive(Clone, Debug, PartialEq)]
struct Term {
    coeff: i32,
    vars: Vec<String>,
}
impl Term {
    fn new(coeff: i32, vars: Vec<String>) -> Self {
        Self { coeff, vars }
    }
}
}