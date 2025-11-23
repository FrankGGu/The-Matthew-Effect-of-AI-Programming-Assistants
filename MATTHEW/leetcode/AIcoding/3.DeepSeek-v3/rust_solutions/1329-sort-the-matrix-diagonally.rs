impl Solution {
    pub fn diagonal_sort(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let mut mat = mat;

        for d in 0..m {
            let mut i = d;
            let mut j = 0;
            let mut diagonal = Vec::new();
            while i < m && j < n {
                diagonal.push(mat[i][j]);
                i += 1;
                j += 1;
            }
            diagonal.sort_unstable();
            i = d;
            j = 0;
            let mut k = 0;
            while i < m && j < n {
                mat[i][j] = diagonal[k];
                i += 1;
                j += 1;
                k += 1;
            }
        }

        for d in 1..n {
            let mut i = 0;
            let mut j = d;
            let mut diagonal = Vec::new();
            while i < m && j < n {
                diagonal.push(mat[i][j]);
                i += 1;
                j += 1;
            }
            diagonal.sort_unstable();
            i = 0;
            j = d;
            let mut k = 0;
            while i < m && j < n {
                mat[i][j] = diagonal[k];
                i += 1;
                j += 1;
                k += 1;
            }
        }

        mat
    }
}