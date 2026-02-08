use std::collections::HashMap;

impl Solution {
    pub fn longest_wpi(hours: Vec<i32>) -> i32 {
        let mut res = 0;
        let mut score = 0;
        let mut seen = HashMap::new();

        for (i, &h) in hours.iter().enumerate() {
            score += if h > 8 { 1 } else { -1 };
            if score > 0 {
                res = i as i32 + 1;
            } else {
                seen.entry(score).or_insert(i);
                if let Some(&j) = seen.get(&(score - 1)) {
                    res = res.max((i - j) as i32);
                }
            }
        }
        res
    }
}