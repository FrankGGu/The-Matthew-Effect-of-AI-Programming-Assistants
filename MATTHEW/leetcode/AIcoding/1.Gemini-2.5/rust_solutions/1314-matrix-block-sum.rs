impl Solution {
    pub fn matrix_block_sum(mat: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();

        let mut ps = vec![vec![0; n + 1]; m + 1];

        for r in 0..m {
            for c in 0..n {
                ps[r + 1][c + 1] = mat[r][c] + ps[r][c + 1] + ps[r + 1][c] - ps[r][c];
            }
        }

        let mut answer = vec![vec![0; n]; m];

        for r in 0..m {
            for c in 0..n {
                let r1 = (r as i32 - k).max(0) as usize;
                let c1 = (c as i32 - k).max(0) as usize;
                let r2 = (r as i32 + k).min(m as i32 - 1) as usize;
                let c2 = (c as i32 + k).min(n as i32 - 1) as usize;

                answer[r][c] = ps[r2 + 1][c2 + 1] - ps[r1][c2 + 1] - ps[r2 + 1][c1] + ps[r1][c1];
            }
        }

        answer
    }
}