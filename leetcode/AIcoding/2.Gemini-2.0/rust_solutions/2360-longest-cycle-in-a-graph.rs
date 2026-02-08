impl Solution {
    pub fn longest_cycle(n: i32, edges: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        for (i, &edge) in edges.iter().enumerate() {
            if edge != -1 {
                adj[i].push(edge as usize);
            }
        }

        let mut visited = vec![0; n];
        let mut path = vec![0; n];
        let mut ans = -1;

        fn dfs(
            u: usize,
            adj: &Vec<Vec<usize>>,
            visited: &mut Vec<i32>,
            path: &mut Vec<i32>,
            ans: &mut i32,
            count: i32,
        ) {
            visited[u] = 1;
            path[u] = count;

            for &v in &adj[u] {
                if visited[v] == 0 {
                    dfs(v, adj, visited, path, ans, count + 1);
                } else if visited[v] == 1 {
                    *ans = (*ans).max(count - path[v] + 1);
                }
            }

            visited[u] = 2;
        }

        for i in 0..n {
            if visited[i] == 0 {
                dfs(i, &adj, &mut visited, &mut path, &mut ans, 1);
            }
        }

        ans
    }
}