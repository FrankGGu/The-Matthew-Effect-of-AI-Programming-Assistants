use std::collections::HashMap;

impl Solution {
    pub fn max_number_of_balloons(text: String) -> i32 {
        let mut counts: HashMap<char, i32> = HashMap::new();
        for c in text.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        let b = counts.get(&'b').unwrap_or(&0);
        let a = counts.get(&'a').unwrap_or(&0);
        let l = counts.get(&'l').unwrap_or(&0) / 2;
        let o = counts.get(&'o').unwrap_or(&0) / 2;
        let n = counts.get(&'n').unwrap_or(&0);

        std::cmp::min(std::cmp::min(*b, *a), std::cmp::min(std::cmp::min(l, o), *n))
    }
}