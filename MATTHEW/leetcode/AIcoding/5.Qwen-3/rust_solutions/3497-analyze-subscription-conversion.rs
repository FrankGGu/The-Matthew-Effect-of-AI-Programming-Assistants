impl Solution {

use std::collections::HashMap;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Subscription {
    user_id: i32,
    start_date: String,
    end_date: String,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Browsing {
    user_id: i32,
    event_date: String,
}

fn subscription_conversion(subscriptions: Vec<Subscription>, browsings: Vec<Browsing>) -> Vec<Vec<String>> {
    let mut result = Vec::new();
    let mut user_map = HashMap::new();

    for browsing in &browsings {
        user_map.entry(browsing.user_id)
            .or_insert_with(Vec::new)
            .push(browsing.event_date.clone());
    }

    for subscription in &subscriptions {
        let user_id = subscription.user_id;
        let start_date = &subscription.start_date;
        let end_date = &subscription.end_date;

        if let Some(dates) = user_map.get(&user_id) {
            for date in dates {
                if date >= start_date && date <= end_date {
                    result.push(vec![
                        user_id.to_string(),
                        start_date.clone(),
                        end_date.clone(),
                        date.clone(),
                    ]);
                    break;
                }
            }
        }
    }

    result
}
}