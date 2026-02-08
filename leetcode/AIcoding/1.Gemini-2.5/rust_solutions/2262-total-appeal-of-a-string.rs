impl Solution {
    pub fn appeal_sum(s: String) -> i64 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut total_appeal: i64 = 0;
        let mut last_seen: [i32; 26] = [-1; 26];

        for i in 0..n {
            let char_code = (s_bytes[i] - b'a') as usize;
            let prev_idx = last_seen[char_code];

            let left_count = (i as i64) - (prev_idx as i64);
            let right_count = (n as i64) - (i as i64);

            total_appeal += left_count * right_count;

            last_seen[char_code] = i as i32;
        }

        total_appeal
    }
}