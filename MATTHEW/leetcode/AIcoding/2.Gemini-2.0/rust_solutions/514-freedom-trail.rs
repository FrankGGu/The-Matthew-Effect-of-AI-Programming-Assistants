impl Solution {
    pub fn find_rotate_steps(ring: String, key: String) -> i32 {
        let ring_chars: Vec<char> = ring.chars().collect();
        let key_chars: Vec<char> = key.chars().collect();
        let m = ring_chars.len();
        let n = key_chars.len();
        let mut pos: Vec<Vec<usize>> = vec![vec![]; 26];
        for i in 0..m {
            pos[(ring_chars[i] as u8 - b'a') as usize].push(i);
        }
        let mut dp: Vec<Vec<i32>> = vec![vec![i32::MAX; m]; n + 1];
        for &p in &pos[(key_chars[0] as u8 - b'a') as usize] {
            dp[0][p] = std::cmp::min(p as i32, (m - p) as i32) + 1;
        }
        for i in 1..n {
            for &j in &pos[(key_chars[i] as u8 - b'a') as usize] {
                for &k in &pos[(key_chars[i - 1] as u8 - b'a') as usize] {
                    let diff = (j as i32 - k as i32).abs();
                    let step = std::cmp::min(diff, m as i32 - diff);
                    if dp[i - 1][k] != i32::MAX {
                        dp[i][j] = std::cmp::min(dp[i][j], dp[i - 1][k] + step + 1);
                    }
                }
            }
        }
        let mut ans = i32::MAX;
        for &p in &pos[(key_chars[n - 1] as u8 - b'a') as usize] {
            ans = std::cmp::min(ans, dp[n - 1][p]);
        }
        ans
    }
}