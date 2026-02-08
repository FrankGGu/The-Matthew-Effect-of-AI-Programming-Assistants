impl Solution {
    pub fn minimum_card_pickup(cards: Vec<i32>) -> i32 {
        let mut map = std::collections::HashMap::new();
        let mut min_pickup = i32::MAX;

        for (i, &card) in cards.iter().enumerate() {
            if let Some(&prev_index) = map.get(&card) {
                min_pickup = min_pickup.min((i - prev_index + 1) as i32);
            }
            map.insert(card, i);
        }

        if min_pickup == i32::MAX {
            -1
        } else {
            min_pickup
        }
    }
}