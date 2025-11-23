impl Solution {
    pub fn mask_pii(s: String) -> String {
        if s.contains('@') {
            // Email masking
            let at_index = s.find('@').unwrap();
            let name_part = &s[0..at_index];
            let domain_part = &s[at_index + 1..];

            let first_char = name_part.chars().next().unwrap().to_ascii_lowercase();
            let last_char = name_part.chars().last().unwrap().to_ascii_lowercase();

            let masked_name = format!("{}{}{}", first_char, "*****", last_char);
            let masked_domain = domain_part.to_ascii_lowercase();

            format!("{}@{}", masked_name, masked_domain)
        } else {
            // Phone number masking
            let digits: String = s.chars().filter(|c| c.is_ascii_digit()).collect();
            let n = digits.len();

            let last_four = &digits[n - 4..];

            if n == 10 {
                format!("***-***-{}", last_four)
            } else {
                let country_code_stars = n - 10;
                let country_code_prefix = format!("+{}", "*".repeat(country_code_stars));
                format!("{}-***-***-{}", country_code_prefix, last_four)
            }
        }
    }
}