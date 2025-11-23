impl Solution {
    pub fn min_operations(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut operations = 0;

        for col in 0..n {
            let mut column: Vec<i32> = Vec::with_capacity(m);
            for row in 0..m {
                column.push(grid[row][col]);
            }
            column.sort();

            for (i, &num) in column.iter().enumerate() {
                operations += (num - (i as i32 + 1)).abs();
            }
        }

        operations
    }
}