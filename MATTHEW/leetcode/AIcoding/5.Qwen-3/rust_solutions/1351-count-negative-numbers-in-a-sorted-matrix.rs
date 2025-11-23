impl Solution {
    pub fn count_negative(grid: Vec<Vec<i32>>) -> i32 {
        let mut count = 0;
        let rows = grid.len();
        let cols = grid[0].len();

        let mut row = 0;
        let mut col = cols as i32 - 1;

        while row < rows && col >= 0 {
            if grid[row][col as usize] < 0 {
                count += rows - row;
                col -= 1;
            } else {
                row += 1;
            }
        }

        count
    }
}