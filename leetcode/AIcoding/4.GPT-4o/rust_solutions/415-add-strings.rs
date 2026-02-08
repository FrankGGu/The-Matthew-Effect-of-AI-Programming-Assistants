impl Solution {
    pub fn add_strings(num1: String, num2: String) -> String {
        let mut result = String::new();
        let mut carry = 0;
        let (mut i, mut j) = (num1.len() as isize - 1, num2.len() as isize - 1);

        while i >= 0 || j >= 0 || carry > 0 {
            let x = if i >= 0 { num1.as_bytes()[i as usize] - b'0' } else { 0 };
            let y = if j >= 0 { num2.as_bytes()[j as usize] - b'0' } else { 0 };
            let sum = x + y + carry;
            carry = sum / 10;
            result.push((sum % 10 + b'0') as char);
            i -= 1;
            j -= 1;
        }

        result.chars().rev().collect()
    }
}