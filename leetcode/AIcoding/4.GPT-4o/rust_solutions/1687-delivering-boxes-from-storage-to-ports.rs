impl Solution {
    pub fn box_delivery(boxes: Vec<i32>, ports_count: i32, max_boxes: i32, max_weight: i32) -> i32 {
        let n = boxes.len();
        let mut dp = vec![vec![std::i32::MAX; (ports_count + 1) as usize]; (n + 1) as usize];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 1..=ports_count {
                let (mut weight, mut count) = (0, 0);
                for k in (1..=max_boxes).rev() {
                    if i >= k as usize {
                        weight += boxes[i - k as usize];
                        count += 1;
                        if weight > max_weight {
                            break;
                        }
                        dp[i][j] = dp[i][j].min(dp[i - k as usize][j - 1] + 1);
                    }
                }
            }
        }

        let mut result = std::i32::MAX;
        for j in 1..=ports_count {
            result = result.min(dp[n][j]);
        }

        if result == std::i32::MAX {
            return -1;
        }
        result
    }
}