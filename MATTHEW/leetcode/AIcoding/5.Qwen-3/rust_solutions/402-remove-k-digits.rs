impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn remove_kdigits(num: String, k: i32) -> String {
        let mut stack = Vec::new();
        let k = k as usize;

        for c in num.chars() {
            while k > 0 && !stack.is_empty() && stack.last().unwrap() > &c {
                stack.pop();
                k -= 1;
            }
            stack.push(c);
        }

        let mut result = stack.into_iter().take(stack.len() - k).collect::<String>();

        result = result.trim_start_matches('0').to_string();

        if result.is_empty() {
            "0".to_string()
        } else {
            result
        }
    }
}
}