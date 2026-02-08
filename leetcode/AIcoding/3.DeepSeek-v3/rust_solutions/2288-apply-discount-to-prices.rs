impl Solution {
    pub fn discount_prices(sentence: String, discount: i32) -> String {
        let discount_factor = (100 - discount) as f64 / 100.0;
        let words: Vec<&str> = sentence.split_whitespace().collect();
        let mut res = Vec::new();

        for word in words {
            if word.starts_with('$') && word.len() > 1 {
                if let Ok(num) = word[1..].parse::<f64>() {
                    let discounted = num * discount_factor;
                    res.push(format!("${:.2}", discounted));
                    continue;
                }
            }
            res.push(word.to_string());
        }

        res.join(" ")
    }
}