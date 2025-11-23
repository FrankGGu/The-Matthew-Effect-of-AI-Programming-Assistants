impl Solution {
    pub fn diagonal_sort(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();

        let mut result = mat.clone();

        for i in 0..m {
            let mut diagonal = Vec::new();
            let mut r = i;
            let mut c = 0;
            while r < m && c < n {
                diagonal.push(result[r][c]);
                r += 1;
                c += 1;
            }
            diagonal.sort();
            let mut r = i;
            let mut c = 0;
            let mut k = 0;
            while r < m && c < n {
                result[r][c] = diagonal[k];
                r += 1;
                c += 1;
                k += 1;
            }
        }

        for j in 1..n {
            let mut diagonal = Vec::new();
            let mut r = 0;
            let mut c = j;
            while r < m && c < n {
                diagonal.push(result[r][c]);
                r += 1;
                c += 1;
            }
            diagonal.sort();
            let mut r = 0;
            let mut c = j;
            let mut k = 0;
            while r < m && c < n {
                result[r][c] = diagonal[k];
                r += 1;
                c += 1;
                k += 1;
            }
        }

        result
    }
}