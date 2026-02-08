impl Solution {
    pub fn fill_grid(n: i32) -> Vec<Vec<i32>> {
        let mut grid = vec![vec![0; n as usize]; n as usize];
        let mut num = 1;

        for i in 0..n {
            for j in 0..n {
                if (i + j) % 2 == 0 {
                    grid[i as usize][j as usize] = num;
                    num += 1;
                }
            }
        }

        for i in 0..n {
            for j in 0..n {
                if (i + j) % 2 != 0 {
                    grid[i as usize][j as usize] = num;
                    num += 1;
                }
            }
        }

        grid
    }
}