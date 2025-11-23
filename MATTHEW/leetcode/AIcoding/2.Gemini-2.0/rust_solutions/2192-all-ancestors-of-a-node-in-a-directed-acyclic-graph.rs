impl Solution {
    pub fn get_ancestors(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut in_degree: Vec<i32> = vec![0; n];
        for edge in &edges {
            adj[edge[0] as usize].push(edge[1] as usize);
            in_degree[edge[1] as usize] += 1;
        }

        let mut ancestors: Vec<Vec<i32>> = vec![vec![]; n];
        for i in 0..n {
            let mut q = std::collections::VecDeque::new();
            let mut visited: Vec<bool> = vec![false; n];
            q.push_back(i);
            visited[i] = true;

            while let Some(u) = q.pop_front() {
                for v in 0..n {
                    if adj[v].contains(&u) && !visited[v] {
                        ancestors[u].push(v as i32);
                        visited[v] = true;
                        q.push_back(v);
                    }
                }
            }
            ancestors[i].sort();
        }

        ancestors
    }
}