use std::collections::HashMap;

impl Solution {
    pub fn has_groups_size_x(deck: Vec<i32>) -> bool {
        let mut counts = HashMap::new();
        for &card in &deck {
            *counts.entry(card).or_insert(0) += 1;
        }

        let mut gcd_value = 0;
        for &count in counts.values() {
            gcd_value = Self::gcd(gcd_value, count);
            if gcd_value < 2 {
                return false;
            }
        }
        gcd_value >= 2
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 { a } else { Self::gcd(b, a % b) }
    }
}