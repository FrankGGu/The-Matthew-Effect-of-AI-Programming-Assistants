fn find_valid_emails(address: Vec<String>) -> Vec<String> {
    address
        .into_iter()
        .filter(|email| {
            let parts: Vec<&str> = email.split('@').collect();
            if parts.len() != 2 {
                return false;
            }

            let local = parts[0];
            let domain = parts[1];

            if local.is_empty() || domain.is_empty() {
                return false;
            }

            if domain.chars().filter(|c| *c == '.').count() == 0 {
                return false;
            }

            let domain_parts: Vec<&str> = domain.split('.').collect();
             if domain_parts.len() < 2 {
                return false;
            }

            for part in &domain_parts {
                if part.is_empty() {
                    return false;
                }
            }

            let mut valid_local = true;
            for c in local.chars() {
                if !c.is_ascii_alphanumeric() && c != '.' && c != '_' && c != '+' && c != '-' {
                    valid_local = false;
                    break;
                }
            }

            let mut valid_domain = true;
            for c in domain.chars() {
                if !c.is_ascii_alphanumeric() && c != '.' && c != '-' {
                    valid_domain = false;
                    break;
                }
            }

            if !valid_local || !valid_domain {
                return false;
            }

            true
        })
        .collect()
}