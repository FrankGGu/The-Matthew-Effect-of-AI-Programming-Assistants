impl Solution {
    pub fn valid_ip_address(ip: String) -> String {
        if ip.contains('.') {
            let parts: Vec<&str> = ip.split('.').collect();
            if parts.len() == 4 && parts.iter().all(|&part| {
                part.len() > 0 && part.len() <= 3 && part.parse::<u8>().is_ok() && part.parse::<u32>().unwrap() == part.parse::<u32>().unwrap() && part.parse::<u32>().unwrap() < 256 && !(part.len() > 1 && part.starts_with('0'))
            }) {
                return "IPv4".to_string();
            }
        } else if ip.contains(':') {
            let parts: Vec<&str> = ip.split(':').collect();
            if parts.len() == 8 && parts.iter().all(|&part| {
                part.len() > 0 && part.len() <= 4 && part.chars().all(|c| c.is_digit(16))
            }) {
                return "IPv6".to_string();
            }
        }
        "Neither".to_string()
    }
}