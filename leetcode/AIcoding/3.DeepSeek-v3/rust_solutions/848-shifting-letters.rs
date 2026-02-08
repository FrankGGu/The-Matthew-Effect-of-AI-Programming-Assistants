impl Solution {
    pub fn shifting_letters(s: String, shifts: Vec<i32>) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut total_shift = 0;
        for i in (0..shifts.len()).rev() {
            total_shift = (total_shift + shifts[i]) % 26;
            let c = chars[i] as u8;
            let shifted = ((c - b'a') as i32 + total_shift) % 26;
            chars[i] = (b'a' + shifted as u8) as char;
        }
        chars.into_iter().collect()
    }
}