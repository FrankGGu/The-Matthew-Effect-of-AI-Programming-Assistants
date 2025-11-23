impl Solution {
    pub fn discount_prices(sentence: String, discount: i32) -> String {
        let mut result_words: Vec<String> = Vec::new();
        let discount_factor = (100 - discount) as f64 / 100.0;

        for word in sentence.split_whitespace() {
            if word.starts_with('$') && word.len() > 1 {
                if let Ok(price_val) = word[1..].parse::<u64>() {
                    let original_price_f64 = price_val as f64;
                    let discounted_price = original_price_f64 * discount_factor;
                    result_words.push(format!("${:.2}", discounted_price));
                } else {
                    result_words.push(word.to_string());
                }
            } else {
                result_words.push(word.to_string());
            }
        }

        result_words.join(" ")
    }
}