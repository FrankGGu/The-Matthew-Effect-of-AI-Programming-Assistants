impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn finding_users_active_minutes(logs: Vec<Vec<String>>, k: i32) -> Vec<i32> {
        let mut user_map = HashMap::new();

        for log in logs {
            let user_id = &log[0];
            let time = &log[1];

            user_map.entry(user_id).or_insert_with(HashSet::new).insert(time);
        }

        let mut result = vec![0; k as usize];

        for (_, times) in user_map {
            let count = times.len() as i32;
            if count > 0 && count <= k {
                result[count as usize - 1] += 1;
            }
        }

        result
    }
}
}