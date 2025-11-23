use std::collections::HashSet;

impl Solution {
    pub fn num_unique_emails(emails: Vec<String>) -> i32 {
        let mut unique_emails: HashSet<String> = HashSet::new();

        for email in emails {
            let mut parts = email.split("@");
            let local_name = parts.next().unwrap();
            let domain_name = parts.next().unwrap();

            let mut processed_local_name = String::new();
            for c in local_name.chars() {
                if c == '+' {
                    break;
                } else if c != '.' {
                    processed_local_name.push(c);
                }
            }

            let unique_email = format!("{}@{}", processed_local_name, domain_name);
            unique_emails.insert(unique_email);
        }

        unique_emails.len() as i32
    }
}