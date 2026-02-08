impl Solution {
    pub fn maximize_win(weights: Vec<i32>, limit: i32) -> i32 {
        let n = weights.len();
        let mut weights = weights;
        weights.sort_unstable();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + weights[i];
        }

        let mut max_wins = 0;
        for i in 0..n {
            let mut left = 0;
            let mut right = i;
            while left < right {
                let mid = (left + right) / 2;
                if weights[mid] >= weights[i] - limit {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            max_wins = max_wins.max(i + 1 - left);
        }

        max_wins
    }
}