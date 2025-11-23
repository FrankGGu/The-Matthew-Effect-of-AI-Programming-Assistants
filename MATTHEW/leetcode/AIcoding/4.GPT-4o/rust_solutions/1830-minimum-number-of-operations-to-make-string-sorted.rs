impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let mut dp = vec![0; 26];
        let n = s.len();

        for c in s.chars() {
            let idx = (c as usize - 'a' as usize);
            for j in (0..=idx).rev() {
                dp[j] += 1;
            }
        }

        n - dp.iter().max().unwrap()
    }
}