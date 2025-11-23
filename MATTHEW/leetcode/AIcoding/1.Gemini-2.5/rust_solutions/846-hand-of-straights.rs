use std::collections::BTreeMap;

impl Solution {
    pub fn is_n_straight_hand(hand: Vec<i32>, group_size: i32) -> bool {
        if hand.len() % group_size as usize != 0 {
            return false;
        }

        let mut counts: BTreeMap<i32, i32> = BTreeMap::new();
        for card in hand {
            *counts.entry(card).or_insert(0) += 1;
        }

        while !counts.is_empty() {
            let &start_card = counts.keys().next().unwrap();

            for i in 0..group_size {
                let current_card = start_card + i;
                if let Some(count) = counts.get_mut(&current_card) {
                    *count -= 1;
                    if *count == 0 {
                        counts.remove(&current_card);
                    }
                } else {
                    return false;
                }
            }
        }

        true
    }
}