impl Solution {
    pub fn video_stitching(clips: Vec<Vec<i32>>, time: i32) -> i32 {
        let mut dp = vec![-1; (time + 1) as usize];
        dp[0] = 0;

        for i in 1..=time {
            for clip in &clips {
                if clip[0] < i && clip[1] >= i {
                    if dp[clip[0] as usize] != -1 {
                        dp[i as usize] = dp[i as usize].max(dp[clip[0] as usize] + 1);
                    }
                }
            }
        }

        dp[time as usize]
    }
}