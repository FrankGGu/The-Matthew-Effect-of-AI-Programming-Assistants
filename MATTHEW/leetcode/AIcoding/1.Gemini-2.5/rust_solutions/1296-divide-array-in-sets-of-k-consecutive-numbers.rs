use std::collections::BTreeMap;

impl Solution {
    pub fn is_n_straight_hand(hand: Vec<i32>, k: i32) -> bool {
        let n = hand.len();
        let k_usize = k as usize;

        if n % k_usize != 0 {
            return false;
        }

        if k == 1 {
            return true;
        }

        let mut counts: BTreeMap<i32, i32> = BTreeMap::new();
        for card in hand {
            *counts.entry(card).or_insert(0) += 1;
        }

        while let Some((&first_card, &count)) = counts.iter().next() {
            if count == 0 {
                counts.remove(&first_card);
                continue;
            }

            let required_sets = count;

            for i in 0..k {
                let current_card = first_card + i;
                if let Some(card_count) = counts.get_mut(&current_card) {
                    if *card_count < required_sets {
                        return false;
                    }
                    *card_count -= required_sets;
                    if *card_count == 0 {
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