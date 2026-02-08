pub fn count_routes(locations: Vec<i32>, start: i32, finish: i32, fuel: i32) -> i32 {
    let n = locations.len();
    let mut dp = vec![vec![-1; fuel as usize + 1]; n];
    let mod_val = 1_000_000_007;

    fn dfs(locations: &Vec<i32>, start: usize, finish: usize, fuel: i32, dp: &mut Vec<Vec<i32>>) -> i32 {
        if fuel < 0 {
            return 0;
        }
        if dp[start][fuel as usize] != -1 {
            return dp[start][fuel as usize];
        }
        let mut count = if start == finish { 1 } else { 0 };
        for next in 0..locations.len() {
            if next != start {
                let cost = (locations[start] - locations[next]).abs();
                count = (count + dfs(locations, next, finish, fuel - cost, dp)) % mod_val;
            }
        }
        dp[start][fuel as usize] = count;
        count
    }

    dfs(&locations, start as usize, finish as usize, fuel, &mut dp)
}