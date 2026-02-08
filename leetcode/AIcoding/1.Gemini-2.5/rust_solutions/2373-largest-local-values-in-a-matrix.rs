impl Solution {
    pub fn largest_local(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = grid.len();
        let result_dim = n - 2;
        let mut max_pool = vec![vec![0; result_dim]; result_dim];

        for i in 0..result_dim {
            for j in 0..result_dim {
                let mut current_max = 0; 

                // Iterate through the 3x3 submatrix
                // The submatrix starts at grid[i][j] and ends at grid[i+2][j+2]
                for x in i..(i + 3) {
                    for y in j..(j + 3) {
                        current_max = current_max.max(grid[x][y]);
                    }
                }
                max_pool[i][j] = current_max;
            }
        }
        max_pool
    }
}