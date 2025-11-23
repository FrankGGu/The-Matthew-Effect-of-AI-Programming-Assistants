impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn can_rearrange_to_palindrome(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let mut counts = HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        for q in queries {
            let index = q[0] as usize;
            let new_char = q[1] as u8 as char;
            let old_char = s.chars().nth(index).unwrap();

            if counts[&old_char] == 1 {
                counts.remove(&old_char);
            } else {
                counts.entry(old_char).and_modify(|e| *e -= 1);
            }

            *counts.entry(new_char).or_insert(0) += 1;

            let mut odd_count = 0;
            for &count in counts.values() {
                if count % 2 != 0 {
                    odd_count += 1;
                }
            }

            result.push(odd_count <= 1);
        }

        result
    }
}
}