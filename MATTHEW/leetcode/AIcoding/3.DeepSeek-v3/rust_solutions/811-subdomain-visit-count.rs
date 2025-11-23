use std::collections::HashMap;

impl Solution {
    pub fn subdomain_visits(cpdomains: Vec<String>) -> Vec<String> {
        let mut counts = HashMap::new();
        for domain in cpdomains {
            let parts: Vec<&str> = domain.split_whitespace().collect();
            let count: i32 = parts[0].parse().unwrap();
            let mut subdomains: Vec<&str> = parts[1].split('.').collect();
            for i in 0..subdomains.len() {
                let subdomain = subdomains[i..].join(".");
                *counts.entry(subdomain).or_insert(0) += count;
            }
        }
        counts.into_iter().map(|(k, v)| format!("{} {}", v, k)).collect()
    }
}