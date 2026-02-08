impl Solution {
    pub fn add_binary(a: String, b: String) -> String {
        let mut a_chars = a.chars().rev();
        let mut b_chars = b.chars().rev();
        let mut carry = 0;
        let mut res = String::new();

        loop {
            let a_bit = a_chars.next().map_or(0, |c| c.to_digit(2).unwrap());
            let b_bit = b_chars.next().map_or(0, |c| c.to_digit(2).unwrap());
            let sum = a_bit + b_bit + carry;
            if sum == 0 && a_chars.clone().count() == 0 && b_chars.clone().count() == 0 {
                break;
            }
            res.push_str(&(sum % 2).to_string());
            carry = sum / 2;
        }

        res.chars().rev().collect()
    }
}