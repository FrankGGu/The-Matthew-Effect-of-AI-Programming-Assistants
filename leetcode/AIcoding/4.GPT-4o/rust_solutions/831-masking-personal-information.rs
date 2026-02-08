impl Solution {
    pub fn mask_personal_info(s: String) -> String {
        let s = s.to_lowercase();
        let mut has_email = false;
        let mut name = String::new();
        let mut email = String::new();

        for part in s.split('@') {
            if part.contains('.') {
                has_email = true;
                email = part.to_string();
                break;
            }
            name.push_str(part);
        }

        if has_email {
            let idx = email.find('.').unwrap();
            let local = &email[..idx];
            let domain = &email[idx..];
            return format!("***@{}{}", &domain[1..], &domain);
        }

        let mut masked_name = String::new();
        if name.len() > 1 {
            masked_name.push_str(&format!("{}*****{}", &name[..1], &name[name.len()-1..]));
        } else {
            masked_name.push_str(&format!("{}*****", &name));
        }

        match name.len() {
            0 => masked_name.push_str("*****"),
            _ => masked_name.push_str(&format!(", {}*****", "*****")),
        }

        masked_name
    }
}