use std::collections::HashSet;

impl Solution {
    pub fn num_unique_emails(emails: Vec<String>) -> i32 {
        let mut unique_emails = HashSet::new();

        for email in emails {
            let parts: Vec<&str> = email.split('@').collect();
            let local = parts[0];
            let domain = parts[1];

            let processed_local: String = local.chars()
                .take_while(|&c| c != '+')
                .filter(|&c| c != '.')
                .collect();

            let processed_email = format!("{}@{}", processed_local, domain);
            unique_emails.insert(processed_email);
        }

        unique_emails.len() as i32
    }
}