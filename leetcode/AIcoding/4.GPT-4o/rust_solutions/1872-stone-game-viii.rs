impl Solution {
    pub fn stone_game_viii(stones: Vec<i32>) -> i32 {
        let n = stones.len();
        let mut prefix_sum = stones.clone();
        for i in 1..n {
            prefix_sum[i] += prefix_sum[i - 1];
        }
        let mut max_score = prefix_sum[n - 1];
        let mut result = max_score;
        for i in (1..n - 1).rev() {
            result = result.max(prefix_sum[i] - result);
        }
        result
    }
}