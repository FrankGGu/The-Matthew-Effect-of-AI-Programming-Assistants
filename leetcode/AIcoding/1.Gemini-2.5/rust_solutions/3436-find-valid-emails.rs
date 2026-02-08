use std::collections::HashSet;

impl Solution {
    pub fn num_unique_emails(emails: Vec<String>) -> i32 {
        let mut unique_emails: HashSet<String> = HashSet::new();

        for email in emails {
            let parts: Vec<&str> = email.split('@').collect();
            let local_name = parts[0];
            let domain_name = parts[1];

            let mut processed_local_name = String::new();
            for c in local_name.chars() {
                if c == '+' {
                    break;
                }
                if c != '.' {
                    processed_local_name.push(c);
                }
            }

            let full_email = format!("{}@{}", processed_local_name, domain_name);
            unique_emails.insert(full_email);
        }

        unique_emails.len() as i32
    }
}