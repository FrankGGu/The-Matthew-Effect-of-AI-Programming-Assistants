impl Solution {
    pub fn valid_path(n: i32, edges: Vec<Vec<i32>>, source: i32, destination: i32) -> bool {
        let n = n as usize;
        let source = source as usize;
        let destination = destination as usize;

        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited: Vec<bool> = vec![false; n];
        let mut q: Vec<usize> = Vec::new();
        q.push(source);
        visited[source] = true;

        while !q.is_empty() {
            let u = q.remove(0);
            if u == destination {
                return true;
            }

            for &v in &adj[u] {
                if !visited[v] {
                    visited[v] = true;
                    q.push(v);
                }
            }
        }

        false
    }
}