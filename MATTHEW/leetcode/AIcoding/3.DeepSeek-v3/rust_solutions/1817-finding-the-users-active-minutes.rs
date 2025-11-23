use std::collections::HashMap;

impl Solution {
    pub fn finding_users_active_minutes(logs: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let mut user_activity: HashMap<i32, std::collections::HashSet<i32>> = HashMap::new();

        for log in logs {
            let id = log[0];
            let time = log[1];
            user_activity.entry(id).or_default().insert(time);
        }

        let mut result = vec![0; k as usize];

        for (_, times) in user_activity {
            let uam = times.len();
            if uam <= k as usize {
                result[uam - 1] += 1;
            }
        }

        result
    }
}