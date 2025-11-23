impl Solution {
    pub fn count_substrings_that_satisfy_k_constraint_ii(s: String, k: i32) -> i64 {
        let chars: Vec<char> = s.chars().collect();
        Self::count_at_most_k_distinct(&chars, k) - Self::count_at_most_k_distinct(&chars, k - 1)
    }

    fn count_at_most_k_distinct(s: &[char], k_val: i32) -> i64 {
        if k_val < 0 {
            return 0;
        }
        let n = s.len();
        let mut freq = [0; 26];
        let mut distinct_count = 0;
        let mut left = 0;
        let mut total_count = 0;

        for right in 0..n {
            let char_idx = (s[right] as u8 - b'a') as usize;
            if freq[char_idx] == 0 {
                distinct_count += 1;
            }
            freq[char_idx] += 1;

            while distinct_count > k_val {
                let left_char_idx = (s[left] as u8 - b'a') as usize;
                freq[left_char_idx] -= 1;
                if freq[left_char_idx] == 0 {
                    distinct_count -= 1;
                }
                left += 1;
            }
            total_count += (right - left + 1) as i64;
        }
        total_count
    }
}