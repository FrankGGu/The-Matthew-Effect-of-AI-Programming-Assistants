impl Solution {
    pub fn good_subset_of_the_matrix(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();

        // According to the problem description:
        // A subset of rows r_1, r_2, ..., r_k is good if its union is empty.
        // A union of rows is empty if for all j from 0 to n-1,
        // grid[r_1][j] | grid[r_2][j] | ... | grid[r_k][j] = 0.
        //
        // For a bitwise OR of binary values to be 0, all individual values must be 0.
        // This means for every column j, grid[r_1][j] must be 0, grid[r_2][j] must be 0, ..., grid[r_k][j] must be 0.
        // This further implies that every row in the good subset (r_1, ..., r_k) must be the all-zeros row [0, 0, ..., 0].
        //
        // Since the subset must be non-empty, we just need to find a single row that consists of all zeros.
        // If such a row exists, it forms a good subset of size 1.
        // If no such row exists, then no good subset can be formed, because any row we pick would have at least one '1',
        // and thus the bitwise OR of any subset containing it would also have a '1' at that position.

        for i in 0..m {
            let mut is_all_zeros = true;
            for j in 0..n {
                if grid[i][j] == 1 {
                    is_all_zeros = false;
                    break;
                }
            }
            if is_all_zeros {
                return vec![i as i32];
            }
        }

        // If no row of all zeros is found, no good subset exists.
        vec![]
    }
}