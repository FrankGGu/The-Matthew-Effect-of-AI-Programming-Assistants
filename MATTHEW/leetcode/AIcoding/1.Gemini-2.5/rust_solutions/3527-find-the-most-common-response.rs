use std::collections::HashMap;

impl Solution {
    pub fn most_common_response(responses: Vec<String>) -> String {
        let mut counts: HashMap<String, i32> = HashMap::new();

        for response in responses {
            *counts.entry(response).or_insert(0) += 1;
        }

        let mut max_count = 0;
        let mut most_common_response = String::new();

        for (response, count) in counts {
            if count > max_count {
                max_count = count;
                most_common_response = response;
            }
        }

        most_common_response
    }
}