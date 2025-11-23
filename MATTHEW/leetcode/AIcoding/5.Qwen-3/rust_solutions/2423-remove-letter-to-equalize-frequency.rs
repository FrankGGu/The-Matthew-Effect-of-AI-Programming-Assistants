impl Solution {

use std::collections::HashMap;

fn main() {}

fn equalize_frequency(mut s: String) -> bool {
    let mut freq = HashMap::new();
    for c in s.chars() {
        *freq.entry(c).or_insert(0) += 1;
    }

    for i in 0..s.len() {
        let c = s.chars().nth(i).unwrap();
        let count = freq.get(&c).copied().unwrap();
        if count == 1 {
            freq.remove(&c);
        } else {
            *freq.get_mut(&c).unwrap() -= 1;
        }

        let mut unique_freq = std::collections::HashSet::new();
        for &v in freq.values() {
            unique_freq.insert(v);
        }

        if unique_freq.len() == 1 {
            return true;
        }

        if count == 1 {
            freq.insert(c, 1);
        } else {
            *freq.get_mut(&c).unwrap() += 1;
        }
    }

    false
}
}