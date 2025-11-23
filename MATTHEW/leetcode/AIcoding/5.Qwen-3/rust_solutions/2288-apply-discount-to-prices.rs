impl Solution {

use std::str::FromStr;

struct Solution;

impl Solution {
    pub fn discount_prices(s: String, discount: i32) -> String {
        let mut result = String::new();
        let words: Vec<&str> = s.split_whitespace().collect();

        for (i, &word) in words.iter().enumerate() {
            if word.starts_with('$') && word.len() > 1 {
                if let Ok(price) = i32::from_str(&word[1..]) {
                    let discounted = price * (100 - discount) as i32;
                    let discounted_price = discounted as f64 / 100.0;
                    let formatted = format!("${:.2}", discounted_price);
                    result.push_str(&formatted);
                } else {
                    result.push_str(word);
                }
            } else {
                result.push_str(word);
            }

            if i < words.len() - 1 {
                result.push(' ');
            }
        }

        result
    }
}
}