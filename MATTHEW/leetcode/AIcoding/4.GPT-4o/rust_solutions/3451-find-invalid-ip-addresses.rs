pub fn filter_invalid_ip_addresses(ip_addresses: Vec<String>) -> Vec<String> {
    fn is_valid(ip: &str) -> bool {
        if ip.len() < 7 || ip.len() > 15 {
            return false;
        }
        let parts: Vec<&str> = ip.split('.').collect();
        if parts.len() != 4 {
            return false;
        }
        for part in parts {
            if part.is_empty() || part.len() > 3 || part.parse::<u8>().is_err() {
                return false;
            }
            if part.len() > 1 && part.starts_with('0') {
                return false;
            }
        }
        true
    }
    ip_addresses.into_iter().filter(|ip| is_valid(ip)).collect()
}