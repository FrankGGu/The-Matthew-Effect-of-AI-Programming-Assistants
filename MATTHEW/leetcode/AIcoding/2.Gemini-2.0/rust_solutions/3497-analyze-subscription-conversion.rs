use std::collections::HashMap;

fn analyze_subscription_conversion(
    data: Vec<Vec<String>>,
) -> Vec<Vec<String>> {
    let mut user_activity: HashMap<String, Vec<(String, String)>> = HashMap::new();

    for row in data {
        let user_id = row[0].clone();
        let activity_date = row[1].clone();
        let activity_type = row[2].clone();

        user_activity.entry(user_id)
            .or_insert(Vec::new())
            .push((activity_date, activity_type));
    }

    let mut result: Vec<Vec<String>> = Vec::new();

    for (user_id, activities) in user_activity {
        let mut first_subscription_date: Option<String> = None;
        let mut conversion_date: Option<String> = None;

        for (date, activity_type) in &activities {
            if activity_type == "subscription_start" {
                if first_subscription_date.is_none() {
                    first_subscription_date = Some(date.clone());
                }
            } else if activity_type == "conversion" {
                conversion_date = Some(date.clone());
                break;
            }
        }

        if let (Some(start_date), Some(conversion_date)) = (first_subscription_date, conversion_date) {
            result.push(vec![user_id, start_date, conversion_date]);
        }
    }

    result
}