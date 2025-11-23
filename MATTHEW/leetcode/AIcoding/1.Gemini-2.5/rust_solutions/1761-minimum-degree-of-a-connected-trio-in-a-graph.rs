impl Solution {
    pub fn min_trio_degree(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut adj = vec![vec![false; n_usize]; n_usize];
        let mut degree = vec![0; n_usize];

        for edge in edges {
            let u = edge[0] as usize - 1;
            let v = edge[1] as usize - 1;
            adj[u][v] = true;
            adj[v][u] = true;
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut min_trio_degree = i32::MAX;

        for i in 0..n_usize {
            for j in (i + 1)..n_usize {
                if adj[i][j] {
                    for k in (j + 1)..n_usize {
                        if adj[j][k] && adj[k][i] {
                            // Found a connected trio (i, j, k)
                            let current_trio_degree = degree[i] + degree[j] + degree[k] - 6;
                            min_trio_degree = min_trio_degree.min(current_trio_degree);
                        }
                    }
                }
            }
        }

        if min_trio_degree == i32::MAX {
            -1
        } else {
            min_trio_degree
        }
    }
}