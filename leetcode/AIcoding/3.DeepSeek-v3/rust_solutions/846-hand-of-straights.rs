use std::collections::BTreeMap;

impl Solution {
    pub fn is_n_straight_hand(hand: Vec<i32>, group_size: i32) -> bool {
        if hand.len() % group_size as usize != 0 {
            return false;
        }

        let mut count = BTreeMap::new();
        for &num in &hand {
            *count.entry(num).or_insert(0) += 1;
        }

        while let Some(&first) = count.keys().next() {
            for num in first..first + group_size {
                if let Some(c) = count.get_mut(&num) {
                    *c -= 1;
                    if *c == 0 {
                        count.remove(&num);
                    }
                } else {
                    return false;
                }
            }
        }

        true
    }
}