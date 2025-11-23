impl Solution {
    pub fn count_complete_components(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut count = 0;

        for i in 0..n {
            if !visited[i] {
                let mut nodes = vec![];
                Self::dfs(i, &adj, &mut visited, &mut nodes);
                let m = nodes.len();
                let mut is_complete = true;
                for &u in &nodes {
                    if adj[u].len() != m - 1 {
                        is_complete = false;
                        break;
                    }
                }
                if is_complete {
                    count += 1;
                }
            }
        }

        count
    }

    fn dfs(u: usize, adj: &Vec<Vec<usize>>, visited: &mut Vec<bool>, nodes: &mut Vec<usize>) {
        visited[u] = true;
        nodes.push(u);
        for &v in &adj[u] {
            if !visited[v] {
                Self::dfs(v, adj, visited, nodes);
            }
        }
    }
}