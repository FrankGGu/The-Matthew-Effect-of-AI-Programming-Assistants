use std::collections::HashMap;

impl Solution {
    pub fn is_n_straight_hand(hand: Vec<i32>, w: i32) -> bool {
        if hand.len() % w as usize != 0 {
            return false;
        }

        let mut hand = hand;
        hand.sort_unstable();
        let mut count: HashMap<i32, i32> = HashMap::new();

        for &card in &hand {
            *count.entry(card).or_insert(0) += 1;
        }

        for &card in &hand {
            if count.get(&card).unwrap_or(&0) == &0 {
                continue;
            }
            let mut curr_count = *count.get(&card).unwrap();
            if curr_count == 0 {
                continue;
            }
            for i in 0..w {
                let next_card = card + i;
                if count.get(&next_card).unwrap_or(&0) < &curr_count {
                    return false;
                }
                *count.get_mut(&next_card).unwrap() -= curr_count;
            }
        }
        true
    }
}