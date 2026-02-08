impl Solution {
    pub fn appeal_sum(s: String) -> i64 {
        let mut last_pos = vec![-1; 26];
        let mut res = 0;
        let mut sum = 0;

        for (i, c) in s.chars().enumerate() {
            let idx = (c as u8 - b'a') as usize;
            sum += (i as i64 - last_pos[idx]) * (s.len() as i64 - i as i64);
            last_pos[idx] = i as i64;
            res += sum;
        }

        res
    }
}