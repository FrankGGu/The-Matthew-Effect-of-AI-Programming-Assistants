impl Solution {
    pub fn number_of_ways(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut res = 1;
        let mut visited = vec![false; n];
        let mut stack = vec![];
        visited[0] = true;
        stack.push(0);

        while let Some(u) = stack.pop() {
            let mut count = 0;
            for &v in &adj[u] {
                if !visited[v] {
                    visited[v] = true;
                    stack.push(v);
                    count += 1;
                }
            }
            if count > 0 {
                res *= count + 1;
            }
        }

        res
    }
}