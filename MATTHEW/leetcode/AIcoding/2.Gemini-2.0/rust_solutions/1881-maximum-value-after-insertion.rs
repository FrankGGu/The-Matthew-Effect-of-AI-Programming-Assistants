impl Solution {
    pub fn max_value_after_insertion(n: String, x: i32) -> String {
        let mut result = String::new();
        let is_negative = n.starts_with('-');
        if is_negative {
            result.push('-');
            for c in n[1..].chars() {
                let digit = c.to_digit(10).unwrap() as i32;
                if x < digit {
                    result.push_str(&digit.to_string());
                } else {
                    result.push_str(&x.to_string());
                    result.push_str(&n[1..].chars().skip(result.len() - 1).collect::<String>());
                    return result;
                }
            }
            result.push_str(&x.to_string());
        } else {
            for c in n.chars() {
                let digit = c.to_digit(10).unwrap() as i32;
                if x > digit {
                    result.push_str(&x.to_string());
                    result.push_str(&n.chars().skip(result.len()).collect::<String>());
                    return result;
                } else {
                    result.push_str(&digit.to_string());
                }
            }
            result.push_str(&x.to_string());
        }
        result
    }
}