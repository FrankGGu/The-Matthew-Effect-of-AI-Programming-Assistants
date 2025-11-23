use std::collections::HashMap;

pub fn analyze_subscription_conversion(data: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut conversion_count: HashMap<String, HashMap<String, usize>> = HashMap::new();

    for record in data {
        let user_id = &record[0];
        let status = &record[1];
        let date = &record[2];

        if !conversion_count.contains_key(user_id) {
            conversion_count.insert(user_id.clone(), HashMap::new());
        }

        let status_count = conversion_count.get_mut(user_id).unwrap();
        *status_count.entry(status.clone()).or_insert(0) += 1;
    }

    let mut result = vec![];

    for (user_id, status_count) in conversion_count {
        let mut status_vec: Vec<String> = status_count.into_iter().map(|(status, count)| {
            format!("{}:{}", status, count)
        }).collect();

        status_vec.sort();
        let status_str = status_vec.join(", ");
        result.push(vec![user_id, status_str]);
    }

    result.sort();
    result
}