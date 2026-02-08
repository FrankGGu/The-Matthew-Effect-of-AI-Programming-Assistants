use std::collections::HashMap;

impl Solution {
    pub fn find_the_difference(s: String, t: String) -> char {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        for c in t.chars() {
            let entry = count.entry(c).or_insert(0);
            *entry -= 1;
            if *entry < 0 {
                return c;
            }
        }
        ' '
    }
}