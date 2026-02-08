impl Solution {
    pub fn valid_emails(emails: Vec<String>) -> Vec<String> {
        emails.into_iter().filter(|email| {
            let parts: Vec<&str> = email.split('@').collect();
            if parts.len() != 2 {
                return false;
            }
            let (local, domain) = (parts[0], parts[1]);
            if domain.is_empty() || !domain.contains('.') {
                return false;
            }
            let local_filtered: String = local.chars()
                .filter(|&c| c != '.')
                .take_while(|&c| c != '+')
                .collect();
            !local_filtered.is_empty() && local_filtered.chars().all(|c| c.is_ascii_alphabetic() || c.is_ascii_digit())
        }).collect()
    }
}