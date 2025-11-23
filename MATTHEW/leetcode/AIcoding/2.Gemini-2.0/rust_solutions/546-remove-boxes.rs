impl Solution {
    pub fn remove_boxes(boxes: Vec<i32>) -> i32 {
        let n = boxes.len();
        let mut memo = vec![vec![vec![0; n + 1]; n]; n];

        fn solve(boxes: &Vec<i32>, l: usize, r: usize, k: usize, memo: &mut Vec<Vec<Vec<i32>>>) -> i32 {
            if l > r {
                return 0;
            }

            if memo[l][r][k] != 0 {
                return memo[l][r][k];
            }

            let mut l_new = l;
            let mut k_new = k;

            while l_new < r && boxes[l_new] == boxes[l_new + 1] {
                l_new += 1;
                k_new += 1;
            }

            let mut res = (k_new + 1) as i32 * (k_new + 1) as i32 + solve(boxes, l_new + 1, r, 0, memo);

            for i in l_new + 1..=r {
                if boxes[i] == boxes[l_new] {
                    res = res.max(solve(boxes, l_new + 1, i - 1, 0, memo) + solve(boxes, i, r, k_new + 1, memo));
                }
            }

            memo[l][r][k] = res;
            res
        }

        solve(&boxes, 0, n - 1, 0, &mut memo)
    }
}