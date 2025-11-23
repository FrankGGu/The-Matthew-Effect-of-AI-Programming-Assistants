impl Solution {
    pub fn order_of_largest_plus_sign(n: i32, mines: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut grid = vec![vec![1; n]; n];
        for mine in mines {
            grid[mine[0] as usize][mine[1] as usize] = 0;
        }

        let mut left = vec![vec![0; n]; n];
        let mut right = vec![vec![0; n]; n];
        let mut up = vec![vec![0; n]; n];
        let mut down = vec![vec![0; n]; n];

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    left[i][j] = if j > 0 { left[i][j - 1] + 1 } else { 1 };
                    up[i][j] = if i > 0 { up[i - 1][j] + 1 } else { 1 };
                }
            }
        }

        for i in (0..n).rev() {
            for j in (0..n).rev() {
                if grid[i][j] == 1 {
                    right[i][j] = if j < n - 1 { right[i][j + 1] + 1 } else { 1 };
                    down[i][j] = if i < n - 1 { down[i + 1][j] + 1 } else { 1 };
                }
            }
        }

        let mut max_order = 0;
        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    let order = left[i][j].min(right[i][j]).min(up[i][j]).min(down[i][j]);
                    max_order = max_order.max(order);
                }
            }
        }

        max_order
    }
}