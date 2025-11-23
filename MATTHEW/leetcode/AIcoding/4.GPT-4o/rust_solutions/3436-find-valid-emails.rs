impl Solution {
    pub fn num_unique_emails(emails: Vec<String>) -> i32 {
        let mut unique_emails = std::collections::HashSet::new();

        for email in emails {
            let parts: Vec<&str> = email.split('@').collect();
            let local = parts[0].replace(".", "");
            let local = local.split('+').next().unwrap();
            let valid_email = format!("{}@{}", local, parts[1]);
            unique_emails.insert(valid_email);
        }

        unique_emails.len() as i32
    }
}