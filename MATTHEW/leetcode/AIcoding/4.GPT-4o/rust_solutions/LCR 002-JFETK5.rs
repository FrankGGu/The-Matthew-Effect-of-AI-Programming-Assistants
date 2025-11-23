impl Solution {
    pub fn add_binary(a: String, b: String) -> String {
        let mut result = String::new();
        let mut carry = 0;
        let mut i = a.len() as isize - 1;
        let mut j = b.len() as isize - 1;

        while i >= 0 || j >= 0 || carry > 0 {
            let sum = carry 
                + if i >= 0 { a.as_bytes()[i as usize] - b'0' } else { 0 }
                + if j >= 0 { b.as_bytes()[j as usize] - b'0' } else { 0 };
            result.push((sum % 2 + b'0') as char);
            carry = sum / 2;
            i -= 1;
            j -= 1;
        }

        result.chars().rev().collect()
    }
}