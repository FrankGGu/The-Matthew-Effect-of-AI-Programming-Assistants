use std::collections::HashMap;

#[derive(Debug, Clone)]
enum Expr {
    Val(i32),
    Var(String),
    Add(Box<Expr>, Box<Expr>),
    Mul(Box<Expr>, Box<Expr>),
    Let(Vec<(String, Expr)>, Box<Expr>),
}

impl Expr {
    fn evaluate(&self, env: &mut Vec<HashMap<String, i32>>) -> i32 {
        match self {
            Expr::Val(v) => *v,
            Expr::Var(s) => {
                for scope in env.iter().rev() {
                    if let Some(v) = scope.get(s) {
                        return *v;
                    }
                }
                panic!("Variable not found: {}", s);
            }
            Expr::Add(l, r) => l.evaluate(env) + r.evaluate(env),
            Expr::Mul(l, r) => l.evaluate(env) * r.evaluate(env),
            Expr::Let(bindings, body) => {
                env.push(HashMap::new());
                for (var, expr) in bindings {
                    let val = expr.evaluate(env);
                    env.last_mut().unwrap().insert(var.clone(), val);
                }
                let res = body.evaluate(env);
                env.pop();
                res
            }
        }
    }
}

struct Parser {
    chars: Vec<char>,
    pos: usize,
}

impl Parser {
    fn new(s: &str) -> Self {
        Parser {
            chars: s.chars().collect(),
            pos: 0,
        }
    }

    fn skip_whitespace(&mut self) {
        while self.pos < self.chars.len() && self.chars[self.pos].is_whitespace() {
            self.pos += 1;
        }
    }

    fn parse(&mut self) -> Expr {
        self.skip_whitespace();
        if self.chars[self.pos] == '(' {
            self.pos += 1;
            self.skip_whitespace();
            let expr = if self.chars[self.pos] == 'a' {
                self.pos += 3; // "add"
                let left = self.parse();
                let right = self.parse();
                Expr::Add(Box::new(left), Box::new(right))
            } else if self.chars[self.pos] == 'm' {
                self.pos += 3; // "mul"
                let left = self.parse();
                let right = self.parse();
                Expr::Mul(Box::new(left), Box::new(right))
            } else {
                self.pos += 3; // "let"
                let mut bindings = Vec::new();
                loop {
                    self.skip_whitespace();
                    if self.chars[self.pos] == '(' || self.chars[self.pos].is_ascii_digit() || self.chars[self.pos] == '-' {
                        let body = self.parse();
                        return Expr::Let(bindings, Box::new(body));
                    }
                    let var = self.parse_var();
                    let expr = self.parse();
                    bindings.push((var, expr));
                }
            };
            self.skip_whitespace();
            self.pos += 1; // ")"
            expr
        } else if self.chars[self.pos] == '-' || self.chars[self.pos].is_ascii_digit() {
            self.parse_val()
        } else {
            Expr::Var(self.parse_var())
        }
    }

    fn parse_val(&mut self) -> Expr {
        let mut s = String::new();
        if self.chars[self.pos] == '-' {
            s.push('-');
            self.pos += 1;
        }
        while self.pos < self.chars.len() && self.chars[self.pos].is_ascii_digit() {
            s.push(self.chars[self.pos]);
            self.pos += 1;
        }
        Expr::Val(s.parse().unwrap())
    }

    fn parse_var(&mut self) -> String {
        let mut s = String::new();
        while self.pos < self.chars.len() && self.chars[self.pos].is_ascii_lowercase() {
            s.push(self.chars[self.pos]);
            self.pos += 1;
        }
        s
    }
}

impl Solution {
    pub fn evaluate(expression: String) -> i32 {
        let mut parser = Parser::new(&expression);
        let expr = parser.parse();
        expr.evaluate(&mut vec![HashMap::new()])
    }
}