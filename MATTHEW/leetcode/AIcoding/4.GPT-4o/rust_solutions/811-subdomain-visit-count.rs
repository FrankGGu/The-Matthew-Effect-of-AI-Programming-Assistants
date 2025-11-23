use std::collections::HashMap;

pub fn subdomain_visits(cpdomains: Vec<String>) -> Vec<String> {
    let mut counts = HashMap::new();

    for domain in cpdomains {
        let parts: Vec<&str> = domain.split_whitespace().collect();
        let count: i32 = parts[0].parse().unwrap();
        let domain_name = parts[1];

        let mut subdomain = String::new();
        for part in domain_name.split('.') {
            if !subdomain.is_empty() {
                subdomain = format!("{}.{}", part, subdomain);
            } else {
                subdomain = part.to_string();
            }
            *counts.entry(subdomain.clone()).or_insert(0) += count;
        }
    }

    counts.into_iter()
        .map(|(domain, count)| format!("{} {}", count, domain))
        .collect()
}