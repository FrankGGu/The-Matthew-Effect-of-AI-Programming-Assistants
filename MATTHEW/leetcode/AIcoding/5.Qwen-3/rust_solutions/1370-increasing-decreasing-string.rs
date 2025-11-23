impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sort_string(s: String) -> String {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut result = String::new();
        let mut chars: Vec<char> = count.keys().cloned().collect();
        chars.sort();

        let mut direction = 1;
        while result.len() < s.len() {
            for i in 0..chars.len() {
                let idx = if direction == 1 { i } else { chars.len() - 1 - i };
                let c = chars[idx];
                if count[&c] > 0 {
                    result.push(c);
                    count.get_mut(&c).map(|x| *x -= 1);
                }
            }
            direction *= -1;
        }

        result
    }
}
}