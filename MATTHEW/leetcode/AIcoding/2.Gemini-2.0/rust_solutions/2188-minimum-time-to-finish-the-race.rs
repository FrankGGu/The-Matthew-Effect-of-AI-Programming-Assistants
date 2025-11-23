impl Solution {
    pub fn minimum_time(tires: Vec<Vec<i32>>, change_time: i32, num_laps: i32) -> i32 {
        let mut min_tire_time = vec![i32::MAX; 20];
        for tire in tires {
            let f = tire[0];
            let r = tire[1];
            let mut time = 0;
            let mut total_time = 0;
            for i in 0..20 {
                time = f * (r.pow(i as u32) as i32);
                if time > 1000 {
                    break;
                }
                total_time += time;
                min_tire_time[i as usize] = min_tire_time[i as usize].min(total_time);
                if f * (r.pow((i + 1) as u32) as i32) > 2000 + f {
                    break;
                }
            }
        }

        let mut dp = vec![i32::MAX; num_laps as usize + 1];
        dp[0] = 0;

        for i in 1..=num_laps as usize {
            for j in 1..=i.min(19) {
                if min_tire_time[j - 1] != i32::MAX && dp[i - j] != i32::MAX {
                    dp[i] = dp[i].min(dp[i - j] + min_tire_time[j - 1] + change_time);
                }
            }
            if dp[i - 1] != i32::MAX && min_tire_time[0] != i32::MAX {
                dp[i] = dp[i].min(dp[i - 1] + min_tire_time[0] + change_time);
            }
        }

        dp[num_laps as usize] - change_time
    }
}