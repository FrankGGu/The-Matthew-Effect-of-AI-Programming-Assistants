impl Solution {
    pub fn shifting_letters(s: String, shifts: Vec<i32>) -> String {
        let n = s.len();
        let mut shifts_sum = vec![0; n];
        let mut current_sum: i64 = 0;

        for i in (0..n).rev() {
            current_sum += shifts[i] as i64;
            shifts_sum[i] = (current_sum % 26 + 26) % 26;
        }

        let mut result = String::new();
        for i in 0..n {
            let char_code = s.as_bytes()[i] as u8 - b'a';
            let shifted_char_code = ((char_code as i32 + shifts_sum[i] as i32) % 26 + 26) % 26;
            result.push((b'a' + shifted_char_code as u8) as char);
        }

        result
    }
}