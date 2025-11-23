impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_eat(candy_types: Vec<i32>, days: Vec<i32>, favorite_day: i32, favorite_candy_type: i32) -> bool {
        let mut type_to_days = HashMap::new();
        for (i, &candy) in candy_types.iter().enumerate() {
            type_to_days.entry(candy).or_insert(Vec::new()).push(i as i32);
        }

        if let Some(days_list) = type_to_days.get(&favorite_candy_type) {
            for &day in days_list {
                if day == favorite_day {
                    return true;
                }
            }
        }

        false
    }
}
}