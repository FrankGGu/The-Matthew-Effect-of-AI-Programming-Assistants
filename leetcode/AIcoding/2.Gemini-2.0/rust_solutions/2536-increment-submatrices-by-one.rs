impl Solution {
    pub fn range_add_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut matrix = vec![vec![0; n]; n];

        for query in queries {
            let row1 = query[0] as usize;
            let col1 = query[1] as usize;
            let row2 = query[2] as usize;
            let col2 = query[3] as usize;

            for i in row1..=row2 {
                for j in col1..=col2 {
                    matrix[i][j] += 1;
                }
            }
        }

        matrix
    }
}