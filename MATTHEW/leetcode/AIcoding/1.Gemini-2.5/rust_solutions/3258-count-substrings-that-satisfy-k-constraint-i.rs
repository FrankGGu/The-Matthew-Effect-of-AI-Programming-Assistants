impl Solution {
    pub fn count_substrings_that_satisfy_k_constraint_i(s: String, k: i32) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut count = 0;
        let mut left = 0;
        let mut freq = [0; 26]; 
        let mut distinct_count = 0;

        for right in 0..n {
            let r_char_idx = (chars[right] as u8 - b'a') as usize;
            if freq[r_char_idx] == 0 {
                distinct_count += 1;
            }
            freq[r_char_idx] += 1;

            while distinct_count > k {
                let l_char_idx = (chars[left] as u8 - b'a') as usize;
                freq[l_char_idx] -= 1;
                if freq[l_char_idx] == 0 {
                    distinct_count -= 1;
                }
                left += 1;
            }
            count += (right - left + 1) as i32;
        }

        count
    }
}