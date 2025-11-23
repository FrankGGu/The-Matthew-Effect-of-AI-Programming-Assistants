impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn num_unique_emails(emails: Vec<String>) -> i32 {
        let mut unique = HashSet::new();
        for email in emails {
            let parts: Vec<&str> = email.split('@').collect();
            let local = parts[0];
            let domain = parts[1];
            let local_clean = local.split('+').next().unwrap();
            let local_final = local_clean.replace(".", "");
            unique.insert(format!("{}@{}", local_final, domain));
        }
        unique.len() as i32
    }
}

struct Solution;
}