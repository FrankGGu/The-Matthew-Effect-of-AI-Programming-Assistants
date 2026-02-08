use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn count_pairs_of_connectable_servers(edges: Vec<Vec<i32>>, signal_speed: i32) -> Vec<i32> {
        let n = edges.len() + 1;
        let mut graph: Vec<HashMap<usize, i32>> = vec![HashMap::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            graph[u].insert(v, w);
            graph[v].insert(u, w);
        }

        let mut res = vec![0; n];
        for i in 0..n {
            let mut counts = vec![];
            for &(neighbor, weight) in graph[i].iter() {
                let cnt = Self::dfs(neighbor, i, weight, &graph, signal_speed);
                counts.push(cnt);
            }
            let mut total = 0;
            for j in 0..counts.len() {
                for k in j+1..counts.len() {
                    total += counts[j] * counts[k];
                }
            }
            res[i] = total;
        }
        res
    }

    fn dfs(node: usize, parent: usize, sum: i32, graph: &Vec<HashMap<usize, i32>>, signal_speed: i32) -> i32 {
        let mut cnt = if sum % signal_speed == 0 { 1 } else { 0 };
        for (&neighbor, &weight) in graph[node].iter() {
            if neighbor != parent {
                cnt += Self::dfs(neighbor, node, sum + weight, graph, signal_speed);
            }
        }
        cnt
    }
}