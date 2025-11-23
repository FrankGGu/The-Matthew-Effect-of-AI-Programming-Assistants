use std::collections::HashMap;

impl Solution {
    pub fn has_groups_size_x(deck: Vec<i32>) -> bool {
        if deck.len() < 2 {
            return false;
        }

        let mut counts: HashMap<i32, i32> = HashMap::new();
        for card in deck {
            *counts.entry(card).or_insert(0) += 1;
        }

        let mut freq_iter = counts.values();

        let mut result_gcd = match freq_iter.next() {
            Some(&val) => val,
            None => return false,
        };

        for &freq in freq_iter {
            result_gcd = Solution::gcd(result_gcd, freq);
            if result_gcd == 1 {
                return false;
            }
        }

        result_gcd > 1
    }

    fn gcd(mut a: i32, mut b: i32) -> i32 {
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        a
    }
}