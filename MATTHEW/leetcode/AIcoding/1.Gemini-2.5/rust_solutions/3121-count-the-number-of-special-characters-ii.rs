impl Solution {
    pub fn number_of_special_chars(s: String) -> i32 {
        let n = s.len();
        let mut max_lc_idx = vec![-1; 26];
        let mut min_uc_idx = vec![n as i32; 26];

        for (i, ch) in s.chars().enumerate() {
            if ch.is_ascii_lowercase() {
                let idx = (ch as u8 - b'a') as usize;
                max_lc_idx[idx] = max_lc_idx[idx].max(i as i32);
            } else if ch.is_ascii_uppercase() {
                let idx = (ch as u8 - b'A') as usize;
                min_uc_idx[idx] = min_uc_idx[idx].min(i as i32);
            }
        }

        let mut count = 0;
        for i in 0..26 {
            if max_lc_idx[i] != -1 && min_uc_idx[i] != n as i32 {
                if max_lc_idx[i] < min_uc_idx[i] {
                    count += 1;
                }
            }
        }

        count
    }
}