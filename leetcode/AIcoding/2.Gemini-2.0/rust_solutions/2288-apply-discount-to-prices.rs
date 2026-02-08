impl Solution {
    pub fn discount_prices(s: String, discount: i32) -> String {
        let discount_decimal = discount as f64 / 100.0;
        let mut result = String::new();
        let mut current_word = String::new();

        for c in s.chars() {
            if c == ' ' {
                if current_word.starts_with('$') && current_word.len() > 1 {
                    if let Ok(price) = current_word[1..].parse::<f64>() {
                        let discounted_price = price * (1.0 - discount_decimal);
                        result.push_str(&format!("${:.2} ", discounted_price));
                    } else {
                        result.push_str(&current_word);
                        result.push(' ');
                    }
                } else {
                    result.push_str(&current_word);
                    result.push(' ');
                }
                current_word.clear();
            } else {
                current_word.push(c);
            }
        }

        if current_word.starts_with('$') && current_word.len() > 1 {
            if let Ok(price) = current_word[1..].parse::<f64>() {
                let discounted_price = price * (1.0 - discount_decimal);
                result.push_str(&format!("${:.2}", discounted_price));
            } else {
                result.push_str(&current_word);
            }
        } else {
            result.push_str(&current_word);
        }

        result
    }
}