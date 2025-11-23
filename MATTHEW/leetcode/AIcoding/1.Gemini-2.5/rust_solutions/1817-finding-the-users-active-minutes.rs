use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn finding_users_active_minutes(logs: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let mut user_minutes: HashMap<i32, HashSet<i32>> = HashMap::new();

        for log in logs {
            let user_id = log[0];
            let minute = log[1];
            user_minutes.entry(user_id).or_insert_with(HashSet::new).insert(minute);
        }

        let mut uam_counts: HashMap<i32, i32> = HashMap::new();
        for (_, minutes_set) in user_minutes {
            let uam = minutes_set.len() as i32;
            *uam_counts.entry(uam).or_insert(0) += 1;
        }

        let mut result = vec![0; k as usize];

        for (uam_value, count) in uam_counts {
            // The problem asks for answer[x] to be the count of users with UAM = x + 1.
            // This means UAM = 1 corresponds to index 0, UAM = 2 to index 1, etc.
            // So, for a given uam_value, the index is uam_value - 1.
            // We only fill up to k. If uam_value is greater than k, it's outside the bounds
            // of the `result` array as defined by `k`.
            if (uam_value - 1) < k {
                result[(uam_value - 1) as usize] = count;
            }
        }

        result
    }
}