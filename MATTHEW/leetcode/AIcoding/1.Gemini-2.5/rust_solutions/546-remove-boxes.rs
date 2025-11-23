impl Solution {
    pub fn remove_boxes(boxes: Vec<i32>) -> i32 {
        let n = boxes.len();
        if n == 0 {
            return 0;
        }

        // memo[i][j][k] stores the maximum points for the subarray boxes[i..j]
        // assuming there are `k` boxes to the left of boxes[i] that have the same color as boxes[i].
        // `k` can range from 0 to n-1.
        let mut memo = vec![vec![vec![-1; n]; n]; n];

        Self::solve(0, n - 1, 0, &boxes, &mut memo)
    }

    // `i`: start index of the current subarray.
    // `j`: end index of the current subarray.
    // `k`: count of boxes of the same color as `boxes[i]` that are to the left of `boxes[i]`
    //      and are considered part of the same block as `boxes[i]`.
    fn solve(i: usize, j: usize, k: usize, boxes: &[i32], memo: &mut Vec<Vec<Vec<i32>>>) -> i32 {
        if i > j {
            return 0;
        }

        if memo[i][j][k] != -1 {
            return memo[i][j][k];
        }

        // Option 1: Remove `boxes[i]` along with the `k` preceding boxes of the same color.
        // The total number of boxes removed in this block is `k + 1`.
        // Points gained: `(k + 1)^2`.
        // Then solve for the remaining subarray `boxes[i+1..j]` with no preceding same-colored boxes (`k=0`).
        let mut max_points = (k as i32 + 1).pow(2) + Self::solve(i + 1, j, 0, boxes, memo);

        // Option 2: Look for another box `boxes[m]` (where `i < m <= j`) that has the same color as `boxes[i]`.
        // If such a `boxes[m]` is found, we can remove the subarray `boxes[i+1..m-1]` first.
        // After `boxes[i+1..m-1]` is removed, `boxes[i]` and `boxes[m]` become adjacent.
        // `boxes[m]` now effectively has `k + 1` boxes of the same color to its left (the original `k` boxes + `boxes[i]`).
        for m in (i + 1)..=j {
            if boxes[m] == boxes[i] {
                let current_points = Self::solve(i + 1, m - 1, 0, boxes, memo) +
                                     Self::solve(m, j, k + 1, boxes, memo);
                max_points = max_points.max(current_points);
            }
        }

        memo[i][j][k] = max_points;
        max_points
    }
}