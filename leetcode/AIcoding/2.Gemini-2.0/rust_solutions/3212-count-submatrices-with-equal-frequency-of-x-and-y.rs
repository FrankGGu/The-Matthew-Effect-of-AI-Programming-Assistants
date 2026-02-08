impl Solution {
    pub fn count_submatrices(grid: Vec<Vec<i32>>, x: i32, y: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut count = 0;

        for r1 in 0..m {
            for c1 in 0..n {
                for r2 in r1..m {
                    for c2 in c1..n {
                        let mut x_count = 0;
                        let mut y_count = 0;

                        for i in r1..=r2 {
                            for j in c1..=c2 {
                                if grid[i][j] == x {
                                    x_count += 1;
                                } else if grid[i][j] == y {
                                    y_count += 1;
                                }
                            }
                        }

                        if x_count == y_count {
                            count += 1;
                        }
                    }
                }
            }
        }

        count
    }
}