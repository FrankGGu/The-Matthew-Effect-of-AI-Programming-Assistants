impl Solution {
    pub fn valid_ip_address(query_ip: String) -> String {
        if Self::is_ipv4(&query_ip) {
            "IPv4".to_string()
        } else if Self::is_ipv6(&query_ip) {
            "IPv6".to_string()
        } else {
            "Neither".to_string()
        }
    }

    fn is_ipv4(s: &str) -> bool {
        let parts: Vec<&str> = s.split('.').collect();
        if parts.len() != 4 {
            return false;
        }
        for part in parts {
            if part.is_empty() || part.len() > 3 {
                return false;
            }
            if part.len() > 1 && part.starts_with('0') {
                return false;
            }
            if !part.chars().all(|c| c.is_ascii_digit()) {
                return false;
            }
            if let Ok(num) = part.parse::<u8>() {
                if num.to_string() != part {
                    return false;
                }
            } else {
                return false;
            }
        }
        true
    }

    fn is_ipv6(s: &str) -> bool {
        let parts: Vec<&str> = s.split(':').collect();
        if parts.len() != 8 {
            return false;
        }
        for part in parts {
            if part.is_empty() || part.len() > 4 {
                return false;
            }
            if !part.chars().all(|c| c.is_ascii_hexdigit()) {
                return false;
            }
        }
        true
    }
}