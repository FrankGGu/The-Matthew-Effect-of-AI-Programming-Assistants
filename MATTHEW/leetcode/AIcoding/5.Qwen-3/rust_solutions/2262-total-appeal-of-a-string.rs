struct Solution;

impl Solution {
    pub fn total_appeal_sum(s: String) -> i32 {
        let mut last = [0; 26];
        let mut total = 0;
        let mut res = 0;

        for (i, c) in s.chars().enumerate() {
            let idx = (c as u8 - b'a') as usize;
            res += (i as i32 - last[idx] as i32);
            last[idx] = i as i32;
            total += res;
        }

        total
    }
}