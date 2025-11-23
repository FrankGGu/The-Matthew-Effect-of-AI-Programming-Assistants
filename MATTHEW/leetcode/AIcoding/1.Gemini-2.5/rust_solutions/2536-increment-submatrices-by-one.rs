impl Solution {
    pub fn range_add_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n_usize = n as usize;
        let mut diff = vec![vec![0; n_usize + 1]; n_usize + 1];

        for query in queries {
            let r1 = query[0] as usize;
            let c1 = query[1] as usize;
            let r2 = query[2] as usize;
            let c2 = query[3] as usize;

            diff[r1][c1] += 1;
            diff[r1][c2 + 1] -= 1;
            diff[r2 + 1][c1] -= 1;
            diff[r2 + 1][c2 + 1] += 1;
        }

        for i in 0..=n_usize {
            for j in 0..=n_usize {
                if i > 0 {
                    diff[i][j] += diff[i - 1][j];
                }
                if j > 0 {
                    diff[i][j] += diff[i][j - 1];
                }
                if i > 0 && j > 0 {
                    diff[i][j] -= diff[i - 1][j - 1];
                }
            }
        }

        let mut ans = vec![vec![0; n_usize]; n_usize];
        for i in 0..n_usize {
            for j in 0..n_usize {
                ans[i][j] = diff[i][j];
            }
        }

        ans
    }
}