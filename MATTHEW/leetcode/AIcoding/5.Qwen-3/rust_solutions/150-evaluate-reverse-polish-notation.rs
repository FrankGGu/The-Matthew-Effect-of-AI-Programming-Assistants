impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn eval_rpn(tokens: Vec<String>) -> i32 {
        let mut stack = VecDeque::new();

        for token in tokens {
            match token.as_str() {
                "+" => {
                    let b = stack.pop_back().unwrap();
                    let a = stack.pop_back().unwrap();
                    stack.push_back(a + b);
                },
                "-" => {
                    let b = stack.pop_back().unwrap();
                    let a = stack.pop_back().unwrap();
                    stack.push_back(a - b);
                },
                "*" => {
                    let b = stack.pop_back().unwrap();
                    let a = stack.pop_back().unwrap();
                    stack.push_back(a * b);
                },
                "/" => {
                    let b = stack.pop_back().unwrap();
                    let a = stack.pop_back().unwrap();
                    stack.push_back(a / b);
                },
                _ => {
                    let num = token.parse::<i32>().unwrap();
                    stack.push_back(num);
                }
            }
        }

        stack.pop_back().unwrap()
    }
}
}