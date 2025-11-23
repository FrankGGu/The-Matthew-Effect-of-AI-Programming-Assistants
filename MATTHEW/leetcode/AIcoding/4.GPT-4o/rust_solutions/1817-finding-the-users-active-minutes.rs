use std::collections::HashMap;
use std::collections::HashSet;

pub fn finding_users_active_minutes(logs: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
    let mut user_activity: HashMap<i32, HashSet<i32>> = HashMap::new();

    for log in logs {
        let user = log[0];
        let time = log[1];
        user_activity.entry(user).or_insert_with(HashSet::new).insert(time);
    }

    let mut active_minutes_count = vec![0; k as usize];

    for activity in user_activity.values() {
        let minutes = activity.len();
        if minutes > 0 {
            active_minutes_count[minutes - 1] += 1;
        }
    }

    active_minutes_count
}