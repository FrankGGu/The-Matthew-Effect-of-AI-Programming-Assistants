impl Solution {
    pub fn remove_boxes(boxes: Vec<i32>) -> i32 {
        let n = boxes.len();
        let mut dp = vec![vec![vec![0; n]; n]; n];

        fn dfs(boxes: &Vec<i32>, dp: &mut Vec<Vec<Vec<i32>>>, i: usize, j: usize, k: usize) -> i32 {
            if i > j {
                return 0;
            }
            if dp[i][j][k] > 0 {
                return dp[i][j][k];
            }
            let mut res = (k as i32 + 1) * (k as i32 + 1) + dfs(boxes, dp, i + 1, j, 0);
            let mut m = i + 1;
            while m <= j {
                if boxes[m] == boxes[i] {
                    res = res.max(dfs(boxes, dp, i + 1, m - 1, 0) + dfs(boxes, dp, m, j, k + 1));
                }
                m += 1;
            }
            dp[i][j][k] = res;
            res
        }

        dfs(&boxes, &mut dp, 0, n - 1, 0)
    }
}