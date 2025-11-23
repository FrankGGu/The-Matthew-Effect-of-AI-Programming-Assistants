impl Solution {
    pub fn diagonal_sort(mut mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        if m == 0 {
            return mat;
        }
        let n = mat[0].len();
        if n == 0 {
            return mat;
        }

        // Iterate through diagonals starting from the first column (i_start, 0)
        // These diagonals have i - j >= 0
        for i_start in 0..m {
            let mut diagonal_elements = Vec::new();
            let mut r = i_start;
            let mut c = 0;

            // Collect elements along the current diagonal
            while r < m && c < n {
                diagonal_elements.push(mat[r][c]);
                r += 1;
                c += 1;
            }

            // Sort the collected elements
            diagonal_elements.sort_unstable();

            // Put the sorted elements back into the matrix along the same diagonal
            r = i_start;
            c = 0;
            let mut k = 0; // Index for sorted_elements
            while r < m && c < n {
                mat[r][c] = diagonal_elements[k];
                r += 1;
                c += 1;
                k += 1;
            }
        }

        // Iterate through diagonals starting from the first row (0, j_start)
        // We start j_start from 1 because the diagonal starting at (0,0) was already covered
        // in the previous loop (when i_start = 0).
        // These diagonals have i - j < 0
        for j_start in 1..n {
            let mut diagonal_elements = Vec::new();
            let mut r = 0;
            let mut c = j_start;

            // Collect elements along the current diagonal
            while r < m && c < n {
                diagonal_elements.push(mat[r][c]);
                r += 1;
                c += 1;
            }

            // Sort the collected elements
            diagonal_elements.sort_unstable();

            // Put the sorted elements back into the matrix along the same diagonal
            r = 0;
            c = j_start;
            let mut k = 0; // Index for sorted_elements
            while r < m && c < n {
                mat[r][c] = diagonal_elements[k];
                r += 1;
                c += 1;
                k += 1;
            }
        }

        mat
    }
}