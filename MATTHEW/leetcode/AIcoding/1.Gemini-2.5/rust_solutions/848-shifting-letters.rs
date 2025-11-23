impl Solution {
    pub fn shifting_letters(s: String, shifts: Vec<i32>) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut current_total_shift: u32 = 0;

        for i in (0..n).rev() {
            current_total_shift = (current_total_shift + (shifts[i] as u32)) % 26;

            let original_pos = (chars[i] as u8 - b'a') as u32;
            let new_pos = (original_pos + current_total_shift) % 26;

            chars[i] = (b'a' + new_pos as u8) as char;
        }

        chars.into_iter().collect()
    }
}