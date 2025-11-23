impl Solution {
    pub fn find_lu_slength(p: String) -> i32 {
        let n = p.len();
        if n == 0 {
            return 0;
        }
        let p_bytes = p.as_bytes();
        let mut dp = vec![0; 26];
        let mut max_len = 0;
        for i in 0..n {
            if i > 0 && (p_bytes[i] as i32 - p_bytes[i - 1] as i32 == 1 || p_bytes[i - 1] as i32 - p_bytes[i] as i32 == 25) {
                max_len += 1;
            } else {
                max_len = 1;
            }
            let index = (p_bytes[i] - b'a') as usize;
            dp[index] = dp[index].max(max_len);
        }
        dp.iter().sum()
    }
}