impl Solution {
    pub fn can_convert_string(s: String, t: String, k: i32) -> bool {
        if s.len() != t.len() {
            return false;
        }
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let mut shifts = vec![0; 26];

        for i in 0..s_chars.len() {
            let s_char = s_chars[i] as i32;
            let t_char = t_chars[i] as i32;
            let diff = (t_char - s_char + 26) % 26;
            if diff != 0 {
                shifts[diff as usize] += 1;
            }
        }

        for i in 1..26 {
            let max_possible = (k - i as i32) / 26 + 1;
            if shifts[i] > max_possible {
                return false;
            }
        }

        true
    }
}