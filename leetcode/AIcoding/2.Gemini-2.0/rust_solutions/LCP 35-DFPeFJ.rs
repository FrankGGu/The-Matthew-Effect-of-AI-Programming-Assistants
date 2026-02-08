impl Solution {
    pub fn max_travelled_cities(n: i32, fuel: i32, charging_stations: Vec<i32>, distances: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![-1; fuel as usize + 1]; n + 1];
        dp[0][fuel as usize] = 0;

        for i in 0..n {
            for j in 0..=fuel as usize {
                if dp[i][j] == -1 {
                    continue;
                }

                // Travel to the next city
                if j >= distances[i] as usize {
                    dp[i + 1][j - distances[i] as usize] = dp[i + 1][j - distances[i] as usize].max(dp[i][j] + 1);
                }

                // Stay at the current city and charge
                let recharged_fuel = (j as i32 + charging_stations[i]).min(fuel);
                dp[i][recharged_fuel as usize] = dp[i][recharged_fuel as usize].max(dp[i][j]);
            }
        }

        let mut ans = -1;
        for j in 0..=fuel as usize {
            ans = ans.max(dp[n][j]);
        }

        ans
    }
}