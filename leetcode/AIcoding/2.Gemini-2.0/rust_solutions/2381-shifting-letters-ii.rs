impl Solution {
    pub fn shifting_letters(s: String, shifts: Vec<Vec<i32>>) -> String {
        let n = s.len();
        let mut diff = vec![0i32; n + 1];

        for shift in &shifts {
            let start = shift[0] as usize;
            let end = shift[1] as usize;
            let direction = shift[2];

            if direction == 1 {
                diff[start] += 1;
                diff[end + 1] -= 1;
            } else {
                diff[start] -= 1;
                diff[end + 1] += 1;
            }
        }

        let mut result = String::new();
        let mut current_shift = 0;

        for i in 0..n {
            current_shift += diff[i];
            let shift_val = (current_shift % 26 + 26) % 26; 
            let original_char = s.as_bytes()[i] as u8;
            let shifted_char = ((original_char - b'a' + shift_val as u8) % 26 + b'a') as char;
            result.push(shifted_char);
        }

        result
    }
}