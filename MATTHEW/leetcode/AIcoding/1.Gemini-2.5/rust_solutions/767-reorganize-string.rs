impl Solution {
    pub fn reorganize_string(s: String) -> String {
        let n = s.len();
        if n == 0 {
            return "".to_string();
        }

        let mut counts = vec![0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut max_freq = 0;
        let mut max_freq_char_idx = 0;
        for i in 0..26 {
            if counts[i] > max_freq {
                max_freq = counts[i];
                max_freq_char_idx = i;
            }
        }

        if max_freq > (n + 1) / 2 {
            return "".to_string();
        }

        let mut result = vec![' '; n];
        let mut idx = 0;

        let max_char = (b'a' + max_freq_char_idx as u8) as char;
        while counts[max_freq_char_idx] > 0 {
            result[idx] = max_char;
            counts[max_freq_char_idx] -= 1;
            idx += 2;
        }

        if idx >= n {
            idx = 1;
        }

        for i in 0..26 {
            let current_char = (b'a' + i as u8) as char;
            while counts[i] > 0 {
                result[idx] = current_char;
                counts[i] -= 1;
                idx += 2;
                if idx >= n {
                    idx = 1;
                }
            }
        }

        result.into_iter().collect()
    }
}