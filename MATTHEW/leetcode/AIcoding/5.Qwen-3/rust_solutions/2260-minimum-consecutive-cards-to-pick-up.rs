impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn minimum_consecutive_cards(packets: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        let mut min_length = i32::MAX;

        for (i, &card) in packets.iter().enumerate() {
            if let Some(&prev_index) = map.get(&card) {
                min_length = std::cmp::min(min_length, (i as i32 - prev_index));
            }
            map.insert(card, i as i32);
        }

        if min_length == i32::MAX {
            -1
        } else {
            min_length
        }
    }
}
}