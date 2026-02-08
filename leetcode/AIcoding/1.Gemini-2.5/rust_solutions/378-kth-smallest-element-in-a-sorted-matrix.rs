impl Solution {
    pub fn kth_smallest(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = matrix.len();
        let m = matrix[0].len();

        let mut low = matrix[0][0];
        let mut high = matrix[n - 1][m - 1];
        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            let count = Self::count_less_equal(&matrix, mid);

            if count >= k {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn count_less_equal(matrix: &Vec<Vec<i32>>, target: i32) -> i32 {
        let n = matrix.len();
        let m = matrix[0].len();
        let mut count = 0;
        let mut r = 0;
        let mut c = m as isize - 1;

        while r < n && c >= 0 {
            if matrix[r][c as usize] <= target {
                count += (c + 1) as i32;
                r += 1;
            } else {
                c -= 1;
            }
        }
        count
    }
}