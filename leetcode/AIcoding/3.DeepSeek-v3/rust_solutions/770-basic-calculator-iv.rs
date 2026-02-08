use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq, Eq)]
struct Term {
    coeff: i32,
    vars: Vec<String>,
}

impl Term {
    fn new(coeff: i32, vars: Vec<String>) -> Self {
        Term { coeff, vars }
    }

    fn key(&self) -> String {
        self.vars.join("*")
    }

    fn is_zero(&self) -> bool {
        self.coeff == 0
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
struct Expression {
    terms: Vec<Term>,
}

impl Expression {
    fn new() -> Self {
        Expression { terms: Vec::new() }
    }

    fn add_term(&mut self, term: Term) {
        if term.is_zero() {
            return;
        }
        let key = term.key();
        for t in &mut self.terms {
            if t.key() == key {
                t.coeff += term.coeff;
                return;
            }
        }
        self.terms.push(term);
    }

    fn multiply(&self, other: &Expression) -> Expression {
        let mut result = Expression::new();
        for t1 in &self.terms {
            for t2 in &other.terms {
                let mut vars = t1.vars.clone();
                vars.extend(t2.vars.clone());
                vars.sort();
                let coeff = t1.coeff * t2.coeff;
                result.add_term(Term::new(coeff, vars));
            }
        }
        result
    }

    fn evaluate(&mut self, eval_map: &HashMap<String, i32>) {
        for term in &mut self.terms {
            let mut new_vars = Vec::new();
            let mut coeff = term.coeff;
            for var in &term.vars {
                if eval_map.contains_key(var) {
                    coeff *= eval_map[var];
                } else {
                    new_vars.push(var.clone());
                }
            }
            term.coeff = coeff;
            term.vars = new_vars;
        }
        self.terms.retain(|t| !t.is_zero());
    }

    fn to_string(&self) -> Vec<String> {
        let mut terms = self.terms.clone();
        terms.sort_by(|a, b| {
            if a.vars.len() != b.vars.len() {
                b.vars.len().cmp(&a.vars.len())
            } else {
                for (va, vb) in a.vars.iter().zip(b.vars.iter()) {
                    let cmp = va.cmp(vb);
                    if cmp != std::cmp::Ordering::Equal {
                        return cmp;
                    }
                }
                std::cmp::Ordering::Equal
            }
        });

        let mut res = Vec::new();
        for term in terms {
            if term.is_zero() {
                continue;
            }
            let mut s = term.coeff.to_string();
            for var in &term.vars {
                s.push('*');
                s.push_str(var);
            }
            res.push(s);
        }
        res
    }
}

struct Solution;

impl Solution {
    pub fn basic_calculator_iv(
        expression: String,
        evalvars: Vec<String>,
        evalints: Vec<i32>,
    ) -> Vec<String> {
        let eval_map: HashMap<String, i32> = evalvars
            .into_iter()
            .zip(evalints.into_iter())
            .collect();
        let tokens = Self::tokenize(&expression);
        let mut parser = Parser::new(tokens);
        let mut expr = parser.parse();
        expr.evaluate(&eval_map);
        expr.to_string()
    }

    fn tokenize(s: &str) -> Vec<String> {
        let mut tokens = Vec::new();
        let mut iter = s.chars().peekable();
        while let Some(&c) = iter.peek() {
            match c {
                ' ' => {
                    iter.next();
                }
                '(' | ')' | '+' | '-' | '*' => {
                    tokens.push(c.to_string());
                    iter.next();
                }
                _ => {
                    let mut token = String::new();
                    while let Some(&ch) = iter.peek() {
                        if ch.is_ascii_alphabetic() || ch.is_ascii_digit() {
                            token.push(ch);
                            iter.next();
                        } else {
                            break;
                        }
                    }
                    tokens.push(token);
                }
            }
        }
        tokens
    }
}

struct Parser {
    tokens: Vec<String>,
    pos: usize,
}

impl Parser {
    fn new(tokens: Vec<String>) -> Self {
        Parser { tokens, pos: 0 }
    }

    fn parse(&mut self) -> Expression {
        self.parse_expression()
    }

    fn parse_expression(&mut self) -> Expression {
        let mut left = self.parse_term();
        while self.pos < self.tokens.len() {
            match self.tokens[self.pos].as_str() {
                "+" | "-" => {
                    let op = self.tokens[self.pos].clone();
                    self.pos += 1;
                    let right = self.parse_term();
                    left = Self::apply_op(&left, &right, &op);
                }
                _ => break,
            }
        }
        left
    }

    fn parse_term(&mut self) -> Expression {
        let mut left = self.parse_factor();
        while self.pos < self.tokens.len() {
            match self.tokens[self.pos].as_str() {
                "*" => {
                    self.pos += 1;
                    let right = self.parse_factor();
                    left = left.multiply(&right);
                }
                _ => break,
            }
        }
        left
    }

    fn parse_factor(&mut self) -> Expression {
        let token = self.tokens[self.pos].clone();
        self.pos += 1;
        if token == "(" {
            let expr = self.parse_expression();
            self.pos += 1; // skip ')'
            expr
        } else if token == "+" {
            self.parse_factor()
        } else if token == "-" {
            let mut expr = self.parse_factor();
            for term in &mut expr.terms {
                term.coeff = -term.coeff;
            }
            expr
        } else if token.chars().all(|c| c.is_ascii_alphabetic()) {
            let mut expr = Expression::new();
            expr.add_term(Term::new(1, vec![token]));
            expr
        } else {
            let coeff = token.parse().unwrap();
            let mut expr = Expression::new();
            expr.add_term(Term::new(coeff, Vec::new()));
            expr
        }
    }

    fn apply_op(left: &Expression, right: &Expression, op: &str) -> Expression {
        let mut result = left.clone();
        match op {
            "+" => {
                for term in &right.terms {
                    result.add_term(term.clone());
                }
            }
            "-" => {
                for term in &right.terms {
                    let mut neg_term = term.clone();
                    neg_term.coeff = -neg_term.coeff;
                    result.add_term(neg_term);
                }
            }
            _ => unreachable!(),
        }
        result
    }
}