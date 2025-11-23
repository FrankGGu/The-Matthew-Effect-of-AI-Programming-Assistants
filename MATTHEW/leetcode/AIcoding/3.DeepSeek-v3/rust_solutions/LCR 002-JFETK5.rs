impl Solution {
    pub fn add_binary(a: String, b: String) -> String {
        let mut res = String::new();
        let mut carry = 0;
        let mut a_chars = a.chars().rev();
        let mut b_chars = b.chars().rev();

        loop {
            let a_bit = a_chars.next().map_or(0, |c| c.to_digit(2).unwrap());
            let b_bit = b_chars.next().map_or(0, |c| c.to_digit(2).unwrap());
            if a_bit == 0 && b_bit == 0 && carry == 0 {
                break;
            }
            let sum = a_bit + b_bit + carry;
            res.push_str(&(sum % 2).to_string());
            carry = sum / 2;
        }

        res.chars().rev().collect()
    }
}