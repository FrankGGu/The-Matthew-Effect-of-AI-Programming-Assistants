impl Solution {
    pub fn count_routes(locations: Vec<i32>, start: i32, finish: i32, fuel: i32) -> i32 {
        let n = locations.len();
        let start = start as usize;
        let finish = finish as usize;
        let mut dp = vec![vec![0; fuel as usize + 1]; n];
        dp[finish][0] = 1;

        let modulo = 1_000_000_007;
        let mut ans = 0;

        for f in 0..=fuel as usize {
            for i in 0..n {
                if dp[i][f] > 0 {
                    if i == start {
                        ans = (ans + dp[i][f]) % modulo;
                    }

                    for j in 0..n {
                        if i != j {
                            let cost = (locations[i] - locations[j]).abs() as usize;
                            if f + cost <= fuel as usize {
                                dp[j][f + cost] = (dp[j][f + cost] + dp[i][f]) % modulo;
                            }
                        }
                    }
                }
            }
        }

        ans
    }
}