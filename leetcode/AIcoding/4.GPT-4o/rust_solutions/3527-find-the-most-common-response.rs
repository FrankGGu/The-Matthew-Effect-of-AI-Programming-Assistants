use std::collections::HashMap;

impl Solution {
    pub fn most_common_response(responses: Vec<String>) -> String {
        let mut count = HashMap::new();
        for response in responses {
            *count.entry(response).or_insert(0) += 1;
        }
        count.into_iter().max_by_key(|&(_, v)| v).map(|(k, _)| k).unwrap()
    }
}