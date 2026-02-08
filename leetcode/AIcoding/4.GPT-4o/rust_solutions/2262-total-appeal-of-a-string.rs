impl Solution {
    pub fn appeal_sum(s: String) -> i64 {
        let n = s.len();
        let mut total_appeal = 0;
        let mut last_seen = vec![-1; 26];

        for (i, c) in s.chars().enumerate() {
            let idx = (c as u8 - b'a') as usize;
            total_appeal += (i as i64 - last_seen[idx]) * (n as i64 - i as i64);
            last_seen[idx] = i as i64;
        }

        total_appeal
    }
}