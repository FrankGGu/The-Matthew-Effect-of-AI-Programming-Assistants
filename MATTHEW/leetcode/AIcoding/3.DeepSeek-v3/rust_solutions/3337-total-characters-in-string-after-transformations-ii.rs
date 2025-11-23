impl Solution {
    pub fn maximum_length(s: String) -> i32 {
        let mut freq = vec![vec![0; 26]; 26];
        let s_chars: Vec<char> = s.chars().collect();
        let mut current_char = s_chars[0];
        let mut current_length = 1;

        for &c in &s_chars[1..] {
            if c == current_char {
                current_length += 1;
            } else {
                let idx = (current_char as u8 - b'a') as usize;
                freq[idx][(current_length - 1).min(25)] += 1;
                current_char = c;
                current_length = 1;
            }
        }
        let idx = (current_char as u8 - b'a') as usize;
        freq[idx][(current_length - 1).min(25)] += 1;

        let mut max_len = -1;
        for c in 0..26 {
            let mut total = 0;
            for l in (0..26).rev() {
                total += freq[c][l];
                if total >= 3 {
                    max_len = max_len.max((l + 1) as i32);
                    break;
                }
            }
        }
        max_len
    }
}