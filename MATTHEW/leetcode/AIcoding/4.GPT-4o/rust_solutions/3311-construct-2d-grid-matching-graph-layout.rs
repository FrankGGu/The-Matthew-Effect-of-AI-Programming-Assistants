impl Solution {
    pub fn construct_grid(m: i32, n: i32, values: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut grid = vec![vec![0; n as usize]; m as usize];
        for i in 0..m {
            for j in 0..n {
                grid[i as usize][j as usize] = values[i as usize][j as usize];
            }
        }
        grid
    }
}