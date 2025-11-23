impl Solution {
    pub fn add_strings(num1: String, num2: String) -> String {
        let mut result_chars = Vec::new();
        let mut i = num1.len() as isize - 1;
        let mut j = num2.len() as isize - 1;
        let num1_bytes = num1.as_bytes();
        let num2_bytes = num2.as_bytes();
        let mut carry = 0;

        while i >= 0 || j >= 0 || carry > 0 {
            let mut current_sum = carry;

            if i >= 0 {
                current_sum += (num1_bytes[i as usize] - b'0') as i32;
                i -= 1;
            }

            if j >= 0 {
                current_sum += (num2_bytes[j as usize] - b'0') as i32;
                j -= 1;
            }

            result_chars.push(((current_sum % 10) as u8 + b'0') as char);
            carry = current_sum / 10;
        }

        result_chars.into_iter().rev().collect()
    }
}