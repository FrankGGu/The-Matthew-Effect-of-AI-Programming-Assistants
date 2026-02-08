impl Solution {
    pub fn remove_boxes(boxes: Vec<i32>) -> i32 {
        let n = boxes.len();
        let mut dp = vec![vec![vec![0; n + 1]; n]; n];

        fn solve(boxes: &Vec<i32>, l: usize, r: usize, k: usize, dp: &mut Vec<Vec<Vec<i32>>>) -> i32 {
            if l > r {
                return 0;
            }

            if dp[l][r][k] > 0 {
                return dp[l][r][k];
            }

            let mut l = l;
            let mut k = k;
            while l < r && boxes[l] == boxes[l + 1] {
                l += 1;
                k += 1;
            }

            let mut ans = (k as i32 + 1) * (k as i32 + 1) + solve(boxes, l + 1, r, 0, dp);

            for i in l + 1..=r {
                if boxes[i] == boxes[l] {
                    ans = ans.max(solve(boxes, l + 1, i - 1, 0, dp) + solve(boxes, i, r, k + 1, dp));
                }
            }

            dp[l][r][k] = ans;
            ans
        }

        solve(&boxes, 0, n - 1, 0, &mut dp)
    }
}