use std::collections::HashMap;

impl Solution {
    pub fn minimum_card_pickup(cards: Vec<i32>) -> i32 {
        let mut last_seen = HashMap::new();
        let mut min_distance = std::i32::MAX;

        for (i, &card) in cards.iter().enumerate() {
            if let Some(&prev_index) = last_seen.get(&card) {
                min_distance = min_distance.min((i - prev_index + 1) as i32);
            }
            last_seen.insert(card, i);
        }

        if min_distance == std::i32::MAX {
            -1
        } else {
            min_distance
        }
    }
}