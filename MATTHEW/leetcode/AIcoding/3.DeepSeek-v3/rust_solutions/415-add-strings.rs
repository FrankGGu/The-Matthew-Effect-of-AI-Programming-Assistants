impl Solution {
    pub fn add_strings(num1: String, num2: String) -> String {
        let mut res = Vec::new();
        let mut carry = 0;
        let mut i = num1.len() as i32 - 1;
        let mut j = num2.len() as i32 - 1;
        let num1 = num1.as_bytes();
        let num2 = num2.as_bytes();

        while i >= 0 || j >= 0 || carry > 0 {
            let n1 = if i >= 0 { num1[i as usize] - b'0' } else { 0 };
            let n2 = if j >= 0 { num2[j as usize] - b'0' } else { 0 };
            let sum = n1 + n2 + carry;
            res.push((sum % 10 + b'0') as char);
            carry = sum / 10;
            i -= 1;
            j -= 1;
        }

        res.iter().rev().collect()
    }
}