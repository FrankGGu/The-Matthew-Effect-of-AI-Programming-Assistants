use std::collections::HashMap;

impl Solution {
    pub fn minimum_card_pickup(cards: Vec<i32>) -> i32 {
        let mut min_length = i32::MAX;
        let mut last_seen: HashMap<i32, usize> = HashMap::new();

        for (i, &card) in cards.iter().enumerate() {
            if let Some(&prev_index) = last_seen.get(&card) {
                let current_length = (i - prev_index + 1) as i32;
                min_length = min_length.min(current_length);
            }
            last_seen.insert(card, i);
        }

        if min_length == i32::MAX {
            -1
        } else {
            min_length
        }
    }
}