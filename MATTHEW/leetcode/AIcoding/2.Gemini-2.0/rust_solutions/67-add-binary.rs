impl Solution {
    pub fn add_binary(a: String, b: String) -> String {
        let mut result = String::new();
        let mut carry = 0;
        let mut i = a.len() as i32 - 1;
        let mut j = b.len() as i32 - 1;

        while i >= 0 || j >= 0 || carry > 0 {
            let mut sum = carry;
            if i >= 0 {
                sum += a.chars().nth(i as usize).unwrap() as i32 - '0' as i32;
            }
            if j >= 0 {
                sum += b.chars().nth(j as usize).unwrap() as i32 - '0' as i32;
            }

            carry = sum / 2;
            result.push_str(&(sum % 2).to_string());

            i -= 1;
            j -= 1;
        }

        result.chars().rev().collect::<String>()
    }
}