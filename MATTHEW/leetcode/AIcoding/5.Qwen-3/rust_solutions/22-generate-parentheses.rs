impl Solution {

use std::vec::Vec;

impl Solution {
    pub fn generate_parenthesis(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        Self::backtrack(&mut result, &mut String::new(), 0, 0, n);
        result
    }

    fn backtrack(result: &mut Vec<String>, current: &mut String, open: i32, close: i32, max: i32) {
        if current.len() as i32 == 2 * max {
            result.push(current.clone());
            return;
        }

        if open < max {
            current.push('(');
            Self::backtrack(result, current, open + 1, close, max);
            current.pop();
        }

        if close < open {
            current.push(')');
            Self::backtrack(result, current, open, close + 1, max);
            current.pop();
        }
    }
}

pub struct Solution;
}