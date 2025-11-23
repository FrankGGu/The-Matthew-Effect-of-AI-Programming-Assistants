use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution {}

impl Solution {
    pub fn shortest_distance(
        n: i32,
        edges: Vec<Vec<i32>>,
        queries: Vec<Vec<i32>>,
    ) -> Vec<i64> {
        let n = n as usize;
        let mut adj_matrix = vec![vec![i64::MAX; n]; n];

        for i in 0..n {
            adj_matrix[i][i] = 0;
        }

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] as i32;
            adj_matrix[u][v] = w as i64;
            adj_matrix[v][u] = w as i64;
        }

        let mut result = vec![];
        let mut added_edges = vec![];

        for query in &queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            let w = query[2] as i32;

            added_edges.push((u, v, w as i64));

            let mut temp_adj_matrix = adj_matrix.clone();

            for &(u, v, w) in &added_edges {
                temp_adj_matrix[u][v] = w;
                temp_adj_matrix[v][u] = w;
            }

            for k in 0..n {
                for i in 0..n {
                    for j in 0..n {
                        if temp_adj_matrix[i][k] != i64::MAX && temp_adj_matrix[k][j] != i64::MAX {
                            temp_adj_matrix[i][j] = std::cmp::min(
                                temp_adj_matrix[i][j],
                                temp_adj_matrix[i][k] + temp_adj_matrix[k][j],
                            );
                        }
                    }
                }
            }

            let mut total_distance = 0i64;
            let mut count = 0;

            for i in 0..n {
                for j in (i + 1)..n {
                    if temp_adj_matrix[i][j] != i64::MAX {
                        total_distance += temp_adj_matrix[i][j];
                        count += 1;
                    }
                }
            }

            if count == 0 {
                result.push(-1);
            } else {
                result.push(total_distance);
            }
        }

        result
    }
}