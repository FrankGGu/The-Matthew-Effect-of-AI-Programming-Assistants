use std::collections::HashMap;

impl Solution {
    pub fn has_groups_size_x(deck: Vec<i32>) -> bool {
        if deck.len() < 2 {
            return false;
        }

        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &card in &deck {
            *counts.entry(card).or_insert(0) += 1;
        }

        let mut gcd_val = 0;
        for &count in counts.values() {
            gcd_val = gcd(gcd_val, count);
        }

        gcd_val >= 2
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}

struct Solution;