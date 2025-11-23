impl Solution {
    pub fn count_routes(locations: Vec<i32>, start: i32, finish: i32, fuel: i32) -> i32 {
        let n = locations.len();
        let start = start as usize;
        let finish = finish as usize;
        let fuel = fuel as usize;
        let mut dp = vec![vec![0; n]; fuel + 1];
        dp[fuel][start] = 1;
        let modulo = 1_000_000_007;

        for f in (0..=fuel).rev() {
            for city in 0..n {
                if dp[f][city] == 0 {
                    continue;
                }
                for next_city in 0..n {
                    if city == next_city {
                        continue;
                    }
                    let distance = (locations[city] - locations[next_city]).abs() as usize;
                    if f >= distance {
                        let new_f = f - distance;
                        dp[new_f][next_city] = (dp[new_f][next_city] + dp[f][city]) % modulo;
                    }
                }
            }
        }

        let mut total = 0;
        for f in 0..=fuel {
            total = (total + dp[f][finish]) % modulo;
        }
        total
    }
}