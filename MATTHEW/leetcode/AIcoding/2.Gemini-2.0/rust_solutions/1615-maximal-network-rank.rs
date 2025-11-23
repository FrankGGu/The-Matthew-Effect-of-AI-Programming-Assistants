impl Solution {
    pub fn maximal_network_rank(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let mut adj = vec![vec![false; n as usize]; n as usize];
        let mut degree = vec![0; n as usize];

        for road in &roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            adj[u][v] = true;
            adj[v][u] = true;
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut max_rank = 0;
        for i in 0..n as usize {
            for j in i + 1..n as usize {
                let mut rank = degree[i] + degree[j];
                if adj[i][j] {
                    rank -= 1;
                }
                max_rank = max_rank.max(rank);
            }
        }

        max_rank
    }
}