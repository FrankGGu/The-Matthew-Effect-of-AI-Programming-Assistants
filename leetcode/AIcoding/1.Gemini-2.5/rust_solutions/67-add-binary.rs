impl Solution {
    pub fn add_binary(a: String, b: String) -> String {
        let mut result_chars: Vec<char> = Vec::new();
        let mut carry = 0;

        let mut i = (a.len() as isize) - 1;
        let mut j = (b.len() as isize) - 1;

        while i >= 0 || j >= 0 || carry == 1 {
            let mut sum = carry;

            if i >= 0 {
                sum += (a.as_bytes()[i as usize] - b'0') as i32;
            }
            if j >= 0 {
                sum += (b.as_bytes()[j as usize] - b'0') as i32;
            }

            result_chars.push(if sum % 2 == 1 { '1' } else { '0' });
            carry = sum / 2;

            i -= 1;
            j -= 1;
        }

        result_chars.reverse();
        result_chars.into_iter().collect()
    }
}