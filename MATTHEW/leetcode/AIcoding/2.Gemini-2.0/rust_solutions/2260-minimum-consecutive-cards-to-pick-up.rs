use std::collections::HashMap;

impl Solution {
    pub fn minimum_card_pickup(cards: Vec<i32>) -> i32 {
        let mut map: HashMap<i32, usize> = HashMap::new();
        let mut min_len = i32::MAX;
        for (i, &card) in cards.iter().enumerate() {
            if let Some(&last_index) = map.get(&card) {
                min_len = min_len.min((i - last_index + 1) as i32);
            }
            map.insert(card, i);
        }
        if min_len == i32::MAX {
            -1
        } else {
            min_len
        }
    }
}