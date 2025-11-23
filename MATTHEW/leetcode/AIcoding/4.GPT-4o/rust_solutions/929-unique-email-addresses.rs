impl Solution {
    pub fn num_unique_emails(emails: Vec<String>) -> i32 {
        let mut unique_emails = std::collections::HashSet::new();

        for email in emails {
            let parts: Vec<&str> = email.split('@').collect();
            let local = parts[0].split('+').next().unwrap().replace(".", "");
            let domain = parts[1];
            unique_emails.insert(format!("{}@{}", local, domain));
        }

        unique_emails.len() as i32
    }
}