impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn simplify_path(path: String) -> String {
        let mut stack = VecDeque::new();
        let parts: Vec<&str> = path.split('/').filter(|s| !s.is_empty()).collect();

        for part in parts {
            match part {
                ".." => {
                    if let Some(_) = stack.pop_back() {}
                },
                "." | "" => {},
                _ => {
                    stack.push_back(part);
                }
            }
        }

        let result: String = stack.into_iter().collect::<Vec<&str>>().join("/");
        format!("/{}", result)
    }
}

pub struct Solution;
}