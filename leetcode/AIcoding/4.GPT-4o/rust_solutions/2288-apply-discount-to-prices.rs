impl Solution {
    pub fn discount_prices(sentence: String, discount: i32) -> String {
        let discount_factor = 1.0 - discount as f64 / 100.0;
        let mut result = String::new();
        for word in sentence.split_whitespace() {
            if word.starts_with('$') {
                if let Ok(price) = word[1..].parse::<f64>() {
                    let discounted_price = price * discount_factor;
                    result.push_str(&format!("${:.2}", discounted_price));
                } else {
                    result.push_str(word);
                }
            } else {
                result.push_str(word);
            }
            result.push(' ');
        }
        result.trim_end().to_string()
    }
}