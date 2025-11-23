impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn subdomain_visits(cpdomains: Vec<String>) -> Vec<String> {
        let mut counts = HashMap::new();
        for domain in cpdomains {
            let parts: Vec<&str> = domain.split_whitespace().collect();
            let count = parts[0].parse::<i32>().unwrap();
            let mut current_domain = parts[1];
            while current_domain.len() > 0 {
                *counts.entry(current_domain.to_string()).or_insert(0) += count;
                if let Some(pos) = current_domain.find('.') {
                    current_domain = &current_domain[pos + 1..];
                } else {
                    break;
                }
            }
        }
        let mut result: Vec<String> = counts
            .into_iter()
            .map(|(domain, count)| format!("{} {}", count, domain))
            .collect();
        result.sort();
        result
    }
}
}