impl Solution {
    pub fn maximum_sum_edge_values(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut graph = vec![vec![0; n as usize]; n as usize];
        for edge in edges {
            graph[edge[0] as usize][edge[1] as usize] = edge[2];
            graph[edge[1] as usize][edge[0] as usize] = edge[2];
        }

        let mut max_sum = 0;
        for i in 0..n as usize {
            for j in (i + 1)..n as usize {
                max_sum = max_sum.max(graph[i][j] + graph[j][i]);
            }
        }

        max_sum
    }
}