impl Solution {
    pub fn shifting_letters(s: String, shifts: Vec<i32>) -> String {
        let n = s.len();
        let mut total_shift = vec![0; n + 1];

        for i in 0..n {
            total_shift[i] += shifts[i];
            if i + 1 < n {
                total_shift[i + 1] -= shifts[i];
            }
        }

        let mut current_shift = 0;
        let mut result = String::new();

        for i in 0..n {
            current_shift += total_shift[i];
            let new_char = ((s.as_bytes()[i] - b'a' + (current_shift % 26 + 26) % 26) % 26 + b'a') as u8) as char;
            result.push(new_char);
        }

        result
    }
}