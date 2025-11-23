impl Solution {
    pub fn can_cross(stones: Vec<i32>) -> bool {
        let n = stones.len();
        if n == 0 || stones[0] != 0 || stones[1] != 1 {
            return false;
        }
        let mut dp: Vec<HashMap<i32, bool>> = vec![HashMap::new(); n];
        dp[0].insert(0, true);

        for i in 0..n {
            for &k in dp[i].keys() {
                for step in -1..=1 {
                    let next_jump = k + step;
                    if next_jump > 0 {
                        let next_pos = stones.binary_search(&(stones[i] + next_jump)).unwrap_or_else(|x| x);
                        if next_pos < n {
                            dp[next_pos].insert(next_jump, true);
                        }
                    }
                }
            }
        }

        !dp[n - 1].is_empty()
    }
}