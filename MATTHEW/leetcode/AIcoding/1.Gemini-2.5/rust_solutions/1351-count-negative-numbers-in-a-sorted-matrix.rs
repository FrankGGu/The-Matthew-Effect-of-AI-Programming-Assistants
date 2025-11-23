impl Solution {
    pub fn count_negatives(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut count = 0;
        let mut r = m as i32 - 1; // Start from the last row
        let mut c = 0;             // Start from the first column

        while r >= 0 && c < n as i32 {
            if grid[r as usize][c as usize] < 0 {
                // If the current element is negative, all elements to its right in this row
                // are also negative (due to non-increasing row sort).
                // Add the number of remaining elements in this row (from current column `c` to `n-1`) to the count.
                count += (n as i32 - c);
                // Move up to the previous row to find more negative numbers.
                r -= 1;
            } else {
                // If the current element is non-negative, then all elements to its left in this row
                // are also non-negative (due to non-increasing row sort).
                // So, we need to move right in the current row to find a potentially negative number.
                c += 1;
            }
        }

        count
    }
}