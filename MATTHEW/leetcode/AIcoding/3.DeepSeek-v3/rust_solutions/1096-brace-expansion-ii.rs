use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn brace_expansion_ii(expression: String) -> Vec<String> {
        let mut queue = VecDeque::new();
        queue.push_back(expression);
        let mut res = HashSet::new();

        while let Some(expr) = queue.pop_front() {
            if let Some(pos) = expr.find('{') {
                let mut balance = 0;
                let mut start = pos;
                let mut end = pos;
                for (i, c) in expr.chars().enumerate().skip(pos) {
                    if c == '{' {
                        balance += 1;
                    } else if c == '}' {
                        balance -= 1;
                    }
                    if balance == 0 {
                        end = i;
                        break;
                    }
                }
                let left = &expr[..start];
                let right = &expr[end + 1..];
                let middle = &expr[start + 1..end];
                for part in middle.split(',') {
                    let new_expr = format!("{}{}{}", left, part, right);
                    queue.push_back(new_expr);
                }
            } else {
                res.insert(expr);
            }
        }

        let mut res: Vec<String> = res.into_iter().collect();
        res.sort();
        res
    }
}