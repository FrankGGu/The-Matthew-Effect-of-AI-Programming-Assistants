impl Solution {
    pub fn path_exists(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut result: Vec<bool> = Vec::new();
        for query in &queries {
            let start = query[0] as usize;
            let end = query[1] as usize;

            let mut visited: Vec<bool> = vec![false; n];
            let mut queue: Vec<usize> = Vec::new();
            queue.push(start);
            visited[start] = true;

            let mut found = false;
            while !queue.is_empty() {
                let u = queue.remove(0);
                if u == end {
                    found = true;
                    break;
                }
                for &v in &adj[u] {
                    if !visited[v] {
                        visited[v] = true;
                        queue.push(v);
                    }
                }
            }
            result.push(found);
        }
        result
    }
}