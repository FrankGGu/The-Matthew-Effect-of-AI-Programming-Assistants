struct Solution;

impl Solution {
    pub fn range_add_queries(mut n: i32, mut queries: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut matrix = vec![vec![0; n as usize]; n as usize];

        for query in queries {
            let (r1, c1, r2, c2) = (query[0], query[1], query[2], query[3]);
            matrix[r1 as usize][c1 as usize] += 1;
            if r2 + 1 < n {
                matrix[r2 as usize + 1][c1 as usize] -= 1;
            }
            if c2 + 1 < n {
                matrix[r1 as usize][c2 as usize + 1] -= 1;
            }
            if r2 + 1 < n && c2 + 1 < n {
                matrix[r2 as usize + 1][c2 as usize + 1] += 1;
            }
        }

        for i in 0..n as usize {
            for j in 1..n as usize {
                matrix[i][j] += matrix[i][j - 1];
            }
        }

        for j in 0..n as usize {
            for i in 1..n as usize {
                matrix[i][j] += matrix[i - 1][j];
            }
        }

        matrix
    }
}