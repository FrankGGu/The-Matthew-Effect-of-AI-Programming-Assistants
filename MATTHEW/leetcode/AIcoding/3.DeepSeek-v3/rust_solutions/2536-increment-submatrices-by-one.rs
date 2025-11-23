impl Solution {
    pub fn range_add_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut diff = vec![vec![0; n + 2]; n + 2];

        for q in queries {
            let (r1, c1, r2, c2) = (q[0] as usize, q[1] as usize, q[2] as usize, q[3] as usize);
            diff[r1 + 1][c1 + 1] += 1;
            diff[r1 + 1][c2 + 2] -= 1;
            diff[r2 + 2][c1 + 1] -= 1;
            diff[r2 + 2][c2 + 2] += 1;
        }

        let mut res = vec![vec![0; n]; n];
        for i in 1..=n {
            for j in 1..=n {
                diff[i][j] += diff[i - 1][j] + diff[i][j - 1] - diff[i - 1][j - 1];
                res[i - 1][j - 1] = diff[i][j];
            }
        }

        res
    }
}