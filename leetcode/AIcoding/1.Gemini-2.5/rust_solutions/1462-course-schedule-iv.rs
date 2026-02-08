impl Solution {
    pub fn check_if_prerequisite(num_courses: i32, prerequisites: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = num_courses as usize;
        let mut adj_matrix = vec![vec![false; n]; n];

        for prereq in prerequisites {
            let u = prereq[0] as usize;
            let v = prereq[1] as usize;
            adj_matrix[u][v] = true;
        }

        for k in 0..n {
            for i in 0..n {
                for j in 0..n {
                    adj_matrix[i][j] = adj_matrix[i][j] || (adj_matrix[i][k] && adj_matrix[k][j]);
                }
            }
        }

        let mut results = Vec::with_capacity(queries.len());
        for query in queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            results.push(adj_matrix[u][v]);
        }

        results
    }
}