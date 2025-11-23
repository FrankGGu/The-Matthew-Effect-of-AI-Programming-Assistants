struct Solution;

impl Solution {
    pub fn add_binary(a: String, b: String) -> String {
        let mut result = String::new();
        let mut i = a.len() as isize - 1;
        let mut j = b.len() as isize - 1;
        let mut carry = 0;

        while i >= 0 || j >= 0 || carry > 0 {
            let sum = carry;
            if i >= 0 {
                carry += a.as_bytes()[i as usize] as i32 - '0' as i32;
                i -= 1;
            }
            if j >= 0 {
                carry += b.as_bytes()[j as usize] as i32 - '0' as i32;
                j -= 1;
            }
            result.push((sum % 2 + '0' as i32) as u8 as char);
            carry /= 2;
        }

        result.chars().rev().collect()
    }
}