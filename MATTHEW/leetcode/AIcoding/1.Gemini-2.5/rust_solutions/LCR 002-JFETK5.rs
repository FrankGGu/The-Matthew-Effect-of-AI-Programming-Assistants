impl Solution {
    pub fn add_binary(a: String, b: String) -> String {
        let mut a_chars = a.chars().rev().peekable();
        let mut b_chars = b.chars().rev().peekable();
        let mut result_vec = Vec::new();
        let mut carry = 0;

        while a_chars.peek().is_some() || b_chars.peek().is_some() || carry != 0 {
            let mut current_sum = carry;

            if let Some(c) = a_chars.next() {
                current_sum += c.to_digit(2).unwrap() as u8;
            }
            if let Some(c) = b_chars.next() {
                current_sum += c.to_digit(2).unwrap() as u8;
            }

            result_vec.push(if current_sum % 2 == 1 { '1' } else { '0' });
            carry = current_sum / 2;
        }

        result_vec.into_iter().rev().collect()
    }
}