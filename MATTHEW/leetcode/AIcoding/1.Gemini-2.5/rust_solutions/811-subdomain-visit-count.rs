use std::collections::HashMap;

impl Solution {
    pub fn subdomain_visits(cpdomains: Vec<String>) -> Vec<String> {
        let mut counts: HashMap<String, i32> = HashMap::new();

        for cpdomain in cpdomains {
            let parts: Vec<&str> = cpdomain.splitn(2, ' ').collect();
            let count: i32 = parts[0].parse().unwrap();
            let mut domain = parts[1];

            let mut current_domain = domain;
            loop {
                *counts.entry(current_domain.to_string()).or_insert(0) += count;

                if let Some(dot_index) = current_domain.find('.') {
                    current_domain = &current_domain[dot_index + 1..];
                } else {
                    break;
                }
            }
        }

        let mut result: Vec<String> = Vec::new();
        for (domain, count) in counts {
            result.push(format!("{} {}", count, domain));
        }

        result
    }
}