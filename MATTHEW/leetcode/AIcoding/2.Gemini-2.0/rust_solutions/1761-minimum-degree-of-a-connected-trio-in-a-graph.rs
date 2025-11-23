impl Solution {
    pub fn min_trio_degree(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![false; n]; n];
        let mut degree = vec![0; n];

        for edge in &edges {
            let u = (edge[0] - 1) as usize;
            let v = (edge[1] - 1) as usize;
            adj[u][v] = true;
            adj[v][u] = true;
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut min_degree = i32::MAX;

        for i in 0..n {
            for j in (i + 1)..n {
                if adj[i][j] {
                    for k in (j + 1)..n {
                        if adj[i][k] && adj[j][k] {
                            min_degree = min_degree.min(
                                degree[i] + degree[j] + degree[k] - 6
                            );
                        }
                    }
                }
            }
        }

        if min_degree == i32::MAX {
            -1
        } else {
            min_degree
        }
    }
}