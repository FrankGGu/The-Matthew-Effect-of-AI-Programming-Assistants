impl Solution {
    pub fn mask_pii(s: String) -> String {
        if s.contains('@') {
            let mut parts = s.split('@');
            let name = parts.next().unwrap().to_lowercase();
            let domain = parts.next().unwrap().to_lowercase();
            let mut masked = String::new();
            masked.push(name.chars().next().unwrap());
            masked.push_str("*****");
            masked.push(name.chars().last().unwrap());
            masked.push('@');
            masked.push_str(&domain);
            masked
        } else {
            let digits: Vec<char> = s.chars().filter(|c| c.is_digit(10)).collect();
            let n = digits.len();
            let mut masked = String::new();
            if n > 10 {
                masked.push('+');
                masked.push_str(&"*".repeat(n - 10));
                masked.push('-');
            }
            masked.push_str("***-***-");
            masked.push_str(&digits[n-4..].iter().collect::<String>());
            masked
        }
    }
}