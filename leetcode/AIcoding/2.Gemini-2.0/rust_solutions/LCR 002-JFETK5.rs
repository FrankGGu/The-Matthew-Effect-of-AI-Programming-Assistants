impl Solution {
    pub fn add_binary(a: String, b: String) -> String {
        let mut a_chars: Vec<char> = a.chars().collect();
        let mut b_chars: Vec<char> = b.chars().collect();
        a_chars.reverse();
        b_chars.reverse();

        let mut carry = 0;
        let mut result = String::new();

        let max_len = std::cmp::max(a_chars.len(), b_chars.len());

        for i in 0..max_len {
            let a_digit = if i < a_chars.len() {
                a_chars[i].to_digit(10).unwrap()
            } else {
                0
            };
            let b_digit = if i < b_chars.len() {
                b_chars[i].to_digit(10).unwrap()
            } else {
                0
            };

            let sum = a_digit + b_digit + carry;
            carry = sum / 2;
            result.push_str(&(sum % 2).to_string());
        }

        if carry > 0 {
            result.push_str(&carry.to_string());
        }

        result.chars().rev().collect()
    }
}