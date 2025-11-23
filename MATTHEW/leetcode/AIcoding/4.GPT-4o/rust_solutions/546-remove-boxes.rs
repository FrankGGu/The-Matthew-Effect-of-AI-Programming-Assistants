impl Solution {
    pub fn remove_boxes(boxes: Vec<i32>) -> i32 {
        let n = boxes.len();
        let mut dp = vec![vec![vec![0; 100]; 100]; 100];

        fn dfs(boxes: &Vec<i32>, left: usize, right: usize, k: usize, dp: &mut Vec<Vec<Vec<i32>>>) -> i32 {
            if left > right {
                return 0;
            }
            if dp[left][right][k] != 0 {
                return dp[left][right][k];
            }
            let mut new_left = left;
            let mut new_k = k;
            while new_left < right && boxes[new_left] == boxes[left] {
                new_left += 1;
                new_k += 1;
            }
            let mut res = (new_k * new_k) as i32 + dfs(boxes, new_left, right, 0, dp);
            for mid in new_left..=right {
                if boxes[mid] == boxes[left] {
                    res = res.max(dfs(boxes, new_left, mid, new_k, dp) + dfs(boxes, mid + 1, right, 0, dp));
                }
            }
            dp[left][right][k] = res;
            res
        }

        dfs(&boxes, 0, n as usize - 1, 0, &mut dp)
    }
}