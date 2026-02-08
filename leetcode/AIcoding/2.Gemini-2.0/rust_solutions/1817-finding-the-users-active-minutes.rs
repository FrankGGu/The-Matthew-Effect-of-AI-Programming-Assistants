use std::collections::HashMap;

impl Solution {
    pub fn finding_users_active_minutes(logs: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let mut user_activities: HashMap<i32, std::collections::HashSet<i32>> = HashMap::new();
        for log in logs {
            let user_id = log[0];
            let activity_time = log[1];
            user_activities.entry(user_id).or_insert(std::collections::HashSet::new()).insert(activity_time);
        }

        let mut result: Vec<i32> = vec![0; k as usize];
        for (_, activities) in user_activities {
            let uam = activities.len() as i32;
            if uam <= k {
                result[(uam - 1) as usize] += 1;
            }
        }

        result
    }
}