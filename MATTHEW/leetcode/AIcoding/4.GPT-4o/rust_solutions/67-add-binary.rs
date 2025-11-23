impl Solution {
    pub fn add_binary(a: String, b: String) -> String {
        let mut result = String::new();
        let mut carry = 0;
        let mut i = a.len() as isize - 1;
        let mut j = b.len() as isize - 1;

        while i >= 0 || j >= 0 || carry > 0 {
            let sum = carry 
                + if i >= 0 { a.chars().nth(i as usize).unwrap() as u32 - '0' as u32 } else { 0 }
                + if j >= 0 { b.chars().nth(j as usize).unwrap() as u32 - '0' as u32 } else { 0 };

            result.push((sum % 2 + '0' as u32) as u8 as char);
            carry = sum / 2;

            if i >= 0 { i -= 1; }
            if j >= 0 { j -= 1; }
        }

        result.chars().rev().collect()
    }
}