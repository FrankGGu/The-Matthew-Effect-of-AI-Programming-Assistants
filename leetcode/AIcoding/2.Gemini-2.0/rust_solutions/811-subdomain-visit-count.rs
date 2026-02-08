use std::collections::HashMap;

impl Solution {
    pub fn subdomain_visits(cpdomains: Vec<String>) -> Vec<String> {
        let mut counts: HashMap<String, i32> = HashMap::new();

        for cpdomain in cpdomains {
            let parts: Vec<&str> = cpdomain.split_whitespace().collect();
            let count: i32 = parts[0].parse().unwrap();
            let domain = parts[1];

            let domain_parts: Vec<&str> = domain.split('.').collect();
            let mut current_domain = String::new();

            for i in (0..domain_parts.len()).rev() {
                if !current_domain.is_empty() {
                    current_domain = format!("{}.{}", domain_parts[i], current_domain);
                } else {
                    current_domain = domain_parts[i].to_string();
                }

                *counts.entry(current_domain.clone()).or_insert(0) += count;
            }
        }

        let mut result: Vec<String> = Vec::new();
        for (domain, count) in counts {
            result.push(format!("{} {}", count, domain));
        }

        result
    }
}