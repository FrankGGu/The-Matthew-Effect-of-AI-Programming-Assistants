use std::collections::HashMap;

impl Solution {
    pub fn has_groups_size_x(deck: Vec<i32>) -> bool {
        let mut count = HashMap::new();
        for card in deck {
            *count.entry(card).or_insert(0) += 1;
        }

        let mut g = 0;
        for &v in count.values() {
            g = gcd(g, v);
            if g == 1 {
                return false;
            }
        }

        g > 1
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}