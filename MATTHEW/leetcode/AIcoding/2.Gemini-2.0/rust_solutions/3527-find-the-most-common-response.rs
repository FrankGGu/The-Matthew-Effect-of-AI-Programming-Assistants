use std::collections::HashMap;

impl Solution {
    pub fn most_common_response(responses: Vec<String>) -> String {
        let mut counts: HashMap<&str, i32> = HashMap::new();
        for response in &responses {
            *counts.entry(response.as_str()).or_insert(0) += 1;
        }

        let mut most_common = "";
        let mut max_count = 0;

        for (response, count) in &counts {
            if *count > max_count {
                most_common = response;
                max_count = *count;
            }
        }

        most_common.to_string()
    }
}