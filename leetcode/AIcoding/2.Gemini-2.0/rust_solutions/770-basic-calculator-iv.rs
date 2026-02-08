use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq, Clone)]
enum Token {
    Number(i32),
    Variable(String),
    Plus,
    Minus,
    Multiply,
    Divide,
    LParen,
    RParen,
}

fn evaluate(expr: &str, evalvars: &Vec<String>, evalints: &Vec<i32>) -> Vec<String> {
    let mut vars = HashMap::new();
    for i in 0..evalvars.len() {
        vars.insert(evalvars[i].clone(), evalints[i]);
    }

    let tokens = tokenize(expr);
    let postfix = shunting_yard(&tokens);
    evaluate_postfix(&postfix, &vars)
}

fn tokenize(expr: &str) -> Vec<Token> {
    let mut tokens = Vec::new();
    let mut chars = expr.chars().peekable();

    while let Some(&c) = chars.peek() {
        match c {
            ' ' => { chars.next(); }
            '+' => { tokens.push(Token::Plus); chars.next(); }
            '-' => { tokens.push(Token::Minus); chars.next(); }
            '*' => { tokens.push(Token::Multiply); chars.next(); }
            '/' => { tokens.push(Token::Divide); chars.next(); }
            '(' => { tokens.push(Token::LParen); chars.next(); }
            ')' => { tokens.push(Token::RParen); chars.next(); }
            '0'..='9' => {
                let mut num_str = String::new();
                while let Some(&d) = chars.peek() {
                    if d.is_digit(10) {
                        num_str.push(d);
                        chars.next();
                    } else {
                        break;
                    }
                }
                tokens.push(Token::Number(num_str.parse().unwrap()));
            }
            'a'..='z' | 'A'..='Z' => {
                let mut var_str = String::new();
                while let Some(&d) = chars.peek() {
                    if d.is_alphabetic() {
                        var_str.push(d);
                        chars.next();
                    } else {
                        break;
                    }
                }
                tokens.push(Token::Variable(var_str));
            }
            _ => { chars.next(); }
        }
    }
    tokens
}

fn precedence(token: &Token) -> i32 {
    match token {
        Token::Plus | Token::Minus => 1,
        Token::Multiply | Token::Divide => 2,
        _ => 0,
    }
}

fn shunting_yard(tokens: &Vec<Token>) -> Vec<Token> {
    let mut output = Vec::new();
    let mut stack: Vec<Token> = Vec::new();

    for token in tokens {
        match token {
            Token::Number(_) | Token::Variable(_) => {
                output.push(token.clone());
            }
            Token::Plus | Token::Minus | Token::Multiply | Token::Divide => {
                while let Some(top) = stack.last() {
                    if precedence(top) >= precedence(token) {
                        output.push(stack.pop().unwrap());
                    } else {
                        break;
                    }
                }
                stack.push(token.clone());
            }
            Token::LParen => {
                stack.push(token.clone());
            }
            Token::RParen => {
                while let Some(top) = stack.last() {
                    if *top != Token::LParen {
                        output.push(stack.pop().unwrap());
                    } else {
                        stack.pop();
                        break;
                    }
                }
            }
        }
    }

    while let Some(top) = stack.pop() {
        output.push(top);
    }

    output
}

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
struct Term {
    coeff: i32,
    vars: Vec<String>,
}

impl Term {
    fn new(coeff: i32, vars: Vec<String>) -> Self {
        let mut sorted_vars = vars.clone();
        sorted_vars.sort();
        Term { coeff, vars: sorted_vars }
    }
}

type Poly = HashMap<Term, i32>;

fn add_poly(p1: &Poly, p2: &Poly) -> Poly {
    let mut result = p1.clone();
    for (term, coeff) in p2 {
        *result.entry(term.clone()).or_insert(0) += coeff;
    }
    result.retain(|_, &v| v != 0);
    result
}

fn multiply_poly(p1: &Poly, p2: &Poly) -> Poly {
    let mut result: Poly = HashMap::new();
    for (term1, coeff1) in p1 {
        for (term2, coeff2) in p2 {
            let mut new_vars = term1.vars.clone();
            new_vars.extend(term2.vars.clone());
            let new_term = Term::new(1, new_vars);
            *result.entry(new_term).or_insert(0) += coeff1 * coeff2;
        }
    }
    result.retain(|_, &v| v != 0);
    result
}

fn evaluate_postfix(postfix: &Vec<Token>, vars: &HashMap<String, i32>) -> Vec<String> {
    let mut stack: Vec<Poly> = Vec::new();

    for token in postfix {
        match token {
            Token::Number(num) => {
                let mut poly: Poly = HashMap::new();
                poly.insert(Term::new(*num, vec![]), 1);
                stack.push(poly);
            }
            Token::Variable(var) => {
                if let Some(&val) = vars.get(var) {
                    let mut poly: Poly = HashMap::new();
                    poly.insert(Term::new(val, vec![]), 1);
                    stack.push(poly);
                } else {
                    let mut poly: Poly = HashMap::new();
                    poly.insert(Term::new(1, vec![var.clone()]), 1);
                    stack.push(poly);
                }
            }
            Token::Plus => {
                let p2 = stack.pop().unwrap();
                let p1 = stack.pop().unwrap();
                stack.push(add_poly(&p1, &p2));
            }
            Token::Minus => {
                let p2 = stack.pop().unwrap();
                let mut neg_p2 = p2.clone();
                for (_, coeff) in neg_p2.iter_mut() {
                    *coeff *= -1;
                }
                let p1 = stack.pop().unwrap();
                stack.push(add_poly(&p1, &neg_p2));
            }
            Token::Multiply => {
                let p2 = stack.pop().unwrap();
                let p1 = stack.pop().unwrap();
                stack.push(multiply_poly(&p1, &p2));
            }
            Token::Divide => {
                 panic!("Division not supported");
            }
            _ => {}
        }
    }

    let mut final_poly = stack.pop().unwrap();

    let mut terms: Vec<(Vec<String>, i32)> = final_poly.into_iter().map(|(term, coeff)| (term.vars, term.coeff * coeff)).collect();
    terms.sort_by(|(vars1, _), (vars2, _)| vars2.len().cmp(&vars1.len()));

    let mut result = Vec::new();
    for (vars, coeff) in terms {
        let mut term_str = String::new();
        term_str.push_str(&coeff.to_string());
        for var in vars {
            term_str.push_str(" * ");
            term_str.push_str(&var);
        }
        if term_str.contains("*") {
             result.push(term_str);
        } else {
             result.push(coeff.to_string());
        }
    }
    result
}

impl Solution {
    pub fn basic_calculator_iv(expression: String, evalvars: Vec<String>, evalints