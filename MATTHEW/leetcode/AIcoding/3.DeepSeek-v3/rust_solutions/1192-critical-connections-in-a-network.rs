use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn critical_connections(n: i32, connections: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for conn in &connections {
            let u = conn[0] as usize;
            let v = conn[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut rank = vec![-1; n];
        let mut res = Vec::new();

        Self::dfs(0, 0, &graph, &mut rank, &mut res);
        res
    }

    fn dfs(u: usize, current_rank: i32, graph: &Vec<Vec<usize>>, rank: &mut Vec<i32>, res: &mut Vec<Vec<i32>>) -> i32 {
        rank[u] = current_rank;
        let mut min_rank = current_rank;

        for &v in &graph[u] {
            if rank[v] == current_rank - 1 || rank[v] == current_rank {
                continue;
            }
            if rank[v] != -1 {
                min_rank = min_rank.min(rank[v]);
                continue;
            }
            let next_rank = Self::dfs(v, current_rank + 1, graph, rank, res);
            min_rank = min_rank.min(next_rank);
            if next_rank > current_rank {
                res.push(vec![u as i32, v as i32]);
            }
        }
        min_rank
    }
}