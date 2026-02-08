use std::collections::HashMap;

impl Solution {
    pub fn analyze_subscription_conversion(events: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut user_events: HashMap<String, (bool, bool)> = HashMap::new();

        for event in events {
            let user_id = &event[1];
            let event_type = &event[2];

            let entry = user_events.entry(user_id.clone()).or_insert((false, false));

            match event_type.as_str() {
                "PAGE_VIEW" => {
                    if event[3] == "Pricing" {
                        entry.0 = true;
                    }
                },
                "SUBSCRIPTION" => {
                    entry.1 = true;
                },
                _ => {}
            }
        }

        let mut total_users = 0;
        let mut viewed_pricing = 0;
        let mut subscribed = 0;
        let mut viewed_and_subscribed = 0;

        for (_, (has_viewed, has_subscribed)) in user_events {
            total_users += 1;
            if has_viewed {
                viewed_pricing += 1;
            }
            if has_subscribed {
                subscribed += 1;
            }
            if has_viewed && has_subscribed {
                viewed_and_subscribed += 1;
            }
        }

        let conversion_rate = if viewed_pricing == 0 {
            0.0
        } else {
            (viewed_and_subscribed as f64 / viewed_pricing as f64) * 100.0
        };

        vec![
            vec!["Total users".to_string(), total_users.to_string()],
            vec!["Users who viewed the pricing page".to_string(), viewed_pricing.to_string()],
            vec!["Users who subscribed".to_string(), subscribed.to_string()],
            vec!["Conversion rate".to_string(), format!("{:.2}%", conversion_rate)],
        ]
    }
}