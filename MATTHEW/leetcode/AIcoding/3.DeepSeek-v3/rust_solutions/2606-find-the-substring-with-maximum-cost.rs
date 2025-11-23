use std::collections::HashMap;

impl Solution {
    pub fn maximum_cost_substring(s: String, chars: String, vals: Vec<i32>) -> i32 {
        let mut char_to_val = HashMap::new();
        for (c, &v) in chars.chars().zip(vals.iter()) {
            char_to_val.insert(c, v);
        }

        let mut max_cost = 0;
        let mut current_cost = 0;

        for c in s.chars() {
            let cost = *char_to_val.get(&c).unwrap_or(&((c as u8 - b'a' + 1) as i32));
            current_cost = (current_cost + cost).max(0);
            max_cost = max_cost.max(current_cost);
        }

        max_cost
    }
}