impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn is_happy(n: i32) -> bool {
        let mut seen = HashSet::new();
        let mut current = n;

        while current != 1 && !seen.contains(&current) {
            seen.insert(current);
            let next = current.to_string()
                .chars()
                .map(|c| c.to_digit(10).unwrap() as i32)
                .map(|d| d * d)
                .sum();
            current = next;
        }

        current == 1
    }
}
}