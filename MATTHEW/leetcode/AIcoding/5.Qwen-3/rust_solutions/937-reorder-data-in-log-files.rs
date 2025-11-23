impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn reorder_log_files(mut logs: Vec<String>) -> Vec<String> {
        let mut letters = Vec::new();
        let mut digits = Vec::new();

        for log in logs.iter() {
            let parts: Vec<&str> = log.split_whitespace().collect();
            if parts[1].chars().next().unwrap().is_ascii_digit() {
                digits.push(log.clone());
            } else {
                letters.push(log.clone());
            }
        }

        letters.sort_by(|a, b| {
            let a_parts: Vec<&str> = a.split_whitespace().collect();
            let b_parts: Vec<&str> = b.split_whitespace().collect();

            let a_rest = &a[a.find(' ').unwrap() + 1..];
            let b_rest = &b[b.find(' ').unwrap() + 1..];

            match a_rest.cmp(b_rest) {
                Ordering::Equal => a_parts[0].cmp(&b_parts[0]),
                other => other,
            }
        });

        let mut result = letters;
        result.extend(digits);
        result
    }
}
}