use std::collections::{HashMap, HashSet};

#[derive(Debug, PartialEq, Eq, PartialOrd, Ord, Clone)]
pub struct Subscription {
    pub user_id: i32,
    pub start_date: String, // YYYY-MM-DD
    pub end_date: String,   // YYYY-MM-DD
    pub sub_type: String,   // e.g., "free", "premium"
}

struct Solution;

impl Solution {
    pub fn analyze_subscription_conversion(subscriptions: Vec<Subscription>) -> Vec<i32> {
        let mut user_subscriptions: HashMap<i32, Vec<Subscription>> = HashMap::new();

        for sub in subscriptions {
            user_subscriptions.entry(sub.user_id).or_insert_with(Vec::new).push(sub);
        }

        let mut converted_users: HashSet<i32> = HashSet::new();

        for (user_id, mut subs) in user_subscriptions {
            subs.sort_by(|a, b| a.start_date.cmp(&b.start_date));

            let mut has_free_before_premium = false;
            let mut found_free = false;

            for sub in subs {
                if sub.sub_type == "free" {
                    found_free = true;
                } else if sub.sub_type == "premium" && found_free {
                    has_free_before_premium = true;
                    break;
                }
            }

            if has_free_before_premium {
                converted_users.insert(user_id);
            }
        }

        let mut result: Vec<i32> = converted_users.into_iter().collect();
        result.sort_unstable();

        result
    }
}