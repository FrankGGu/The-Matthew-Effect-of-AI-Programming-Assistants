use std::collections::HashSet;

impl Solution {
    pub fn min_reorder(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        let mut directed = HashSet::new();

        for conn in connections {
            let u = conn[0] as usize;
            let v = conn[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
            directed.insert((u, v));
        }

        let mut stack = vec![0];
        let mut visited = vec![false; n];
        let mut res = 0;

        while let Some(u) = stack.pop() {
            visited[u] = true;
            for &v in &graph[u] {
                if !visited[v] {
                    if directed.contains(&(u, v)) {
                        res += 1;
                    }
                    stack.push(v);
                }
            }
        }

        res
    }
}