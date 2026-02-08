impl Solution {
    pub fn kth_smallest(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = matrix.len();
        let mut left = matrix[0][0];
        let mut right = matrix[n - 1][n - 1];

        while left < right {
            let mid = left + (right - left) / 2;
            let mut count = 0;
            let mut row = n - 1;
            let mut col = 0;

            while row >= 0 && col < n {
                if matrix[row][col] <= mid {
                    count += row as i32 + 1;
                    col += 1;
                } else {
                    row -= 1;
                }
            }

            if count < k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}