impl Solution {
    pub fn fill_the_grid(m: i32, n: i32) -> Vec<Vec<i32>> {
        let mut grid = vec![vec![0; n as usize]; m as usize];
        let mut num = 1;
        for i in 0..m {
            for j in 0..n {
                if i % 2 == 0 {
                    grid[i as usize][j as usize] = num;
                } else {
                    grid[i as usize][(n - 1 - j) as usize] = num;
                }
                num += 1;
            }
        }
        grid
    }
}