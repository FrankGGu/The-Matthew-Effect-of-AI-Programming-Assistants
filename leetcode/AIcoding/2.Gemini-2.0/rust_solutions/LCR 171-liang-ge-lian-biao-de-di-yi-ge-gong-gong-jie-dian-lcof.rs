impl Solution {
    pub fn training_plan(n: i32, edges: Vec<Vec<i32>>, salary: Vec<i32>) -> Vec<i32> {
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n as usize];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut result = salary.clone();
        let mut visited = vec![false; n as usize];

        fn dfs(u: usize, adj: &Vec<Vec<usize>>, salary: &Vec<i32>, result: &mut Vec<i32>, visited: &mut Vec<bool>) {
            visited[u] = true;
            for &v in &adj[u] {
                if !visited[v] {
                    dfs(v, adj, salary, result, visited);
                    result[u] += result[v];
                }
            }
        }

        dfs(0, &adj, &salary, &mut result, &mut visited);

        result
    }
}