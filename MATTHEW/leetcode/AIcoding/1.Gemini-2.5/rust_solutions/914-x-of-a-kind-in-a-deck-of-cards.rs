use std::collections::HashMap;

impl Solution {
    pub fn has_groups_size_x(deck: Vec<i32>) -> bool {
        if deck.is_empty() {
            return false;
        }

        let mut counts: HashMap<i32, i32> = HashMap::new();
        for card in deck {
            *counts.entry(card).or_insert(0) += 1;
        }

        let mut freqs: Vec<i32> = counts.values().cloned().collect();

        if freqs.is_empty() {
            return false;
        }

        fn gcd(a: i32, b: i32) -> i32 {
            if b == 0 {
                a
            } else {
                gcd(b, a % b)
            }
        }

        let mut result_gcd = freqs[0];
        for i in 1..freqs.len() {
            result_gcd = gcd(result_gcd, freqs[i]);
            if result_gcd == 1 {
                return false;
            }
        }

        result_gcd >= 2
    }
}