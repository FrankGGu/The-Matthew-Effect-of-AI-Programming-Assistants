impl Solution {

use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq, Eq)]
enum Expr {
    Atom(String),
    List(Vec<Expr>),
}

struct Parser<'a> {
    tokens: Vec<&'a str>,
    pos: usize,
}

impl<'a> Parser<'a> {
    fn new(s: &'a str) -> Self {
        let tokens: Vec<_> = s
            .split(|c: char| c.is_whitespace())
            .filter(|s| !s.is_empty())
            .collect();
        Parser { tokens, pos: 0 }
    }

    fn parse(&mut self) -> Expr {
        if self.pos >= self.tokens.len() {
            return Expr::List(vec![]);
        }

        let token = self.tokens[self.pos];
        self.pos += 1;

        if token == "(" {
            let mut list = vec![];
            while self.pos < self.tokens.len() && self.tokens[self.pos] != ")" {
                list.push(self.parse());
            }
            self.pos += 1; // consume ")"
            Expr::List(list)
        } else {
            Expr::Atom(token.to_string())
        }
    }
}

fn parse_lisp(expression: String) -> Expr {
    let mut parser = Parser::new(&expression);
    parser.parse()
}
}