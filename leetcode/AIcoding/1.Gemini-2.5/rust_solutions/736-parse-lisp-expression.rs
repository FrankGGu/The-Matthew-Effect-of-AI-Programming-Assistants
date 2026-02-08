use std::collections::HashMap;
use std::iter::Peekable;
use std::str::Chars;

struct Solution;

impl Solution {
    pub fn evaluate(expression: String) -> i32 {
        let mut chars = expression.chars().peekable();
        let mut scope_stack: Vec<HashMap<String, i32>> = Vec::new();
        scope_stack.push(HashMap::new()); // Push a global scope

        Self::parse_and_eval(&mut chars, &mut scope_stack)
    }

    fn skip_whitespace(chars: &mut Peekable<Chars>) {
        while let Some(' ') = chars.peek() {
            chars.next();
        }
    }

    fn read_token(chars: &mut Peekable<Chars>) -> String {
        Self::skip_whitespace(chars);
        let mut token = String::new();
        if let Some(&c) = chars.peek() {
            if c == '(' || c == ')' {
                token.push(chars.next().unwrap());
                return token;
            } else if c.is_ascii_digit() || c == '-' {
                if c == '-' {
                    token.push(chars.next().unwrap());
                }
                while let Some(&c) = chars.peek() {
                    if c.is_ascii_digit() {
                        token.push(chars.next().unwrap());
                    } else {
                        break;
                    }
                }
            } else if c.is_ascii_lowercase() {
                while let Some(&c) = chars.peek() {
                    if c.is_ascii_lowercase() {
                        token.push(chars.next().unwrap());
                    } else {
                        break;
                    }
                }
            }
        }
        token
    }

    fn lookup_variable(name: &str, scope_stack: &Vec<HashMap<String, i32>>) -> i32 {
        for scope in scope_stack.iter().rev() {
            if let Some(&value) = scope.get(name) {
                return value;
            }
        }
        panic!("Undefined variable: {}", name);
    }

    fn parse_and_eval(chars: &mut Peekable<Chars>, scope_stack: &mut Vec<HashMap<String, i32>>) -> i32 {
        Self::skip_whitespace(chars);

        if let Some(&'(') = chars.peek() {
            chars.next(); // Consume '('
            let op = Self::read_token(chars);

            let result = match op.as_str() {
                "add" => {
                    let exp1 = Self::parse_and_eval(chars, scope_stack);
                    let exp2 = Self::parse_and_eval(chars, scope_stack);
                    exp1 + exp2
                }
                "mult" => {
                    let exp1 = Self::parse_and_eval(chars, scope_stack);
                    let exp2 = Self::parse_and_eval(chars, scope_stack);
                    exp1 * exp2
                }
                "let" => {
                    scope_stack.push(HashMap::new()); // New scope for let expression

                    loop {
                        Self::skip_whitespace(chars);
                        let next_char_peek = chars.peek().unwrap();

                        if *next_char_peek == ')' || *next_char_peek == '(' || next_char_peek.is_ascii_digit() || *next_char_peek == '-' {
                            break; // Body expression follows
                        }

                        let var_name = Self::read_token(chars);
                        let var_value = Self::parse_and_eval(chars, scope_stack);
                        scope_stack.last_mut().unwrap().insert(var_name, var_value);
                    }

                    let body_value = Self::parse_and_eval(chars, scope_stack);
                    scope_stack.pop(); // Pop the let scope
                    body_value
                }
                _ => panic!("Unknown operator or invalid token: {}", op),
            };
            chars.next(); // Consume ')'
            result
        } else {
            let token = Self::read_token(chars);
            if token.starts_with('-') || token.chars().next().unwrap().is_ascii_digit() {
                token.parse::<i32>().unwrap()
            } else {
                Self::lookup_variable(&token, scope_stack)
            }
        }
    }
}