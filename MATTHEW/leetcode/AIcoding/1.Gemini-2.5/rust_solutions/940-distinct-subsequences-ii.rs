impl Solution {
    pub fn distinct_subseq_ii(s: String) -> i32 {
        let modulo: i32 = 1_000_000_007;
        let mut dp: i32 = 0;
        let mut last_occurrence_count: [i32; 26] = [0; 26];

        for char_code in s.bytes() {
            let char_idx = (char_code - b'a') as usize;

            let old_dp = dp;

            dp = (old_dp + (old_dp + 1) - last_occurrence_count[char_idx]) % modulo;

            if dp < 0 {
                dp += modulo;
            }

            last_occurrence_count[char_idx] = (old_dp + 1) % modulo;
        }

        dp
    }
}