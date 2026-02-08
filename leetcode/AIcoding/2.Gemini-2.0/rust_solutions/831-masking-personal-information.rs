impl Solution {
    pub fn mask_pii(s: String) -> String {
        if s.contains('@') {
            let parts: Vec<&str> = s.split('@').collect();
            let name = parts[0];
            let domain = parts[1];
            let name_start = &name[..1];
            let name_end = &name[name.len() - 1..];
            format!("{}*****{}@{}", name_start, name_end, domain).to_lowercase()
        } else {
            let digits: Vec<char> = s.chars().filter(|c| c.is_digit(10)).collect();
            let last_ten: String = digits.iter().skip(digits.len() - 10).collect();
            let local = &last_ten[last_ten.len() - 4..];
            let mut country_code = String::new();
            for _ in 0..digits.len() - 10 {
                country_code.push('*');
            }
            if country_code.is_empty() {
                format!("***-***-{}", local)
            } else {
                format!("+{}***-***-{}", country_code, local)
            }
        }
    }
}