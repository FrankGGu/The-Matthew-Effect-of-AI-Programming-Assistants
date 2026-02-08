impl Solution {
    pub fn matrix_block_sum(mat: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let mut prefix = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                prefix[i][j] = mat[i - 1][j - 1] + prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1];
            }
        }

        let mut res = vec![vec![0; n]; m];
        for i in 0..m {
            for j in 0..n {
                let r1 = (i as i32 - k).max(0) as usize;
                let c1 = (j as i32 - k).max(0) as usize;
                let r2 = (i as i32 + k).min(m as i32 - 1) as usize;
                let c2 = (j as i32 + k).min(n as i32 - 1) as usize;

                res[i][j] = prefix[r2 + 1][c2 + 1] - prefix[r1][c2 + 1] - prefix[r2 + 1][c1] + prefix[r1][c1];
            }
        }
        res
    }
}