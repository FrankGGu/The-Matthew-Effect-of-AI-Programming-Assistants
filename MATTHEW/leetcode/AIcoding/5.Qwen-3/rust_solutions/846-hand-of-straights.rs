impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_n_straight_hand(mut hand: Vec<i32>, group_size: i32) -> bool {
        if group_size == 1 {
            return true;
        }

        let mut count = HashMap::new();
        for card in &hand {
            *count.entry(*card).or_insert(0) += 1;
        }

        hand.sort();

        for card in hand {
            if let Some(&mut cnt) = count.get_mut(&card) {
                if cnt == 0 {
                    continue;
                }

                for i in 0..group_size {
                    let current = card + i as i32;
                    if let Some(&mut c) = count.get_mut(&current) {
                        if c == 0 {
                            return false;
                        }
                        *count.get_mut(&current).unwrap() -= 1;
                    } else {
                        return false;
                    }
                }
            }
        }

        true
    }
}
}