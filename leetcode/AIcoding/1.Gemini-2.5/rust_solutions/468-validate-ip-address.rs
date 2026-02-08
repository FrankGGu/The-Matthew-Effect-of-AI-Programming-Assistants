impl Solution {
    pub fn validate_ip_address(ip: String) -> String {
        if ip.contains('.') && !ip.contains(':') {
            let parts: Vec<&str> = ip.split('.').collect();
            if parts.len() != 4 {
                return "Neither".to_string();
            }
            for part in parts {
                if part.is_empty() || (part.len() > 1 && part.starts_with('0')) {
                    return "Neither".to_string();
                }
                match part.parse::<i32>() {
                    Ok(num) => {
                        if !(0 <= num && num <= 255) {
                            return "Neither".to_string();
                        }
                    }
                    Err(_) => {
                        return "Neither".to_string();
                    }
                }
            }
            "IPv4".to_string()
        } else if ip.contains(':') && !ip.contains('.') {
            let parts: Vec<&str> = ip.split(':').collect();
            if parts.len() != 8 {
                return "Neither".to_string();
            }
            for part in parts {
                if part.is_empty() || part.len() > 4 {
                    return "Neither".to_string();
                }
                for c in part.chars() {
                    if !c.is_ascii_hexdigit() {
                        return "Neither".to_string();
                    }
                }
            }
            "IPv6".to_string()
        } else {
            "Neither".to_string()
        }
    }
}