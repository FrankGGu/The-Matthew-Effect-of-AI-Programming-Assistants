impl Solution {
    pub fn longest_special_substring(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return -1;
        }

        let mut char_run_lengths: Vec<Vec<usize>> = vec![vec![]; 26];

        let s_chars: Vec<char> = s.chars().collect();
        let mut i = 0;
        while i < n {
            let current_char = s_chars[i];
            let mut j = i;
            while j < n && s_chars[j] == current_char {
                j += 1;
            }
            let length = j - i;
            char_run_lengths[(current_char as u8 - b'a') as usize].push(length);
            i = j;
        }

        let mut overall_max_k = -1;

        for char_idx in 0..26 {
            let runs_c = &char_run_lengths[char_idx];
            if runs_c.is_empty() {
                continue;
            }

            let mut freq_c: Vec<usize> = vec![0; n + 1];
            for &len in runs_c {
                freq_c[len] += 1;
            }

            let mut current_total_count = 0; 
            let mut current_num_runs = 0;    

            for k in (1..=n).rev() {
                current_total_count += current_num_runs;
                current_total_count += freq_c[k];
                current_num_runs += freq_c[k];

                if current_total_count >= k {
                    overall_max_k = overall_max_k.max(k as i32);
                    break; 
                }
            }
        }

        overall_max_k
    }
}