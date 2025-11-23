impl Solution {
    pub fn is_valid_ipv4(ip: String) -> bool {
        let parts: Vec<&str> = ip.split('.').collect();

        if parts.len() != 4 {
            return false;
        }

        for part in parts {
            if part.is_empty() {
                return false;
            }

            if part.len() > 1 && part.starts_with('0') {
                return false;
            }

            if !part.chars().all(|c| c.is_ascii_digit()) {
                return false;
            }

            match part.parse::<u8>() {
                Ok(_) => {}
                Err(_) => {
                    return false;
                }
            }
        }

        true
    }
}