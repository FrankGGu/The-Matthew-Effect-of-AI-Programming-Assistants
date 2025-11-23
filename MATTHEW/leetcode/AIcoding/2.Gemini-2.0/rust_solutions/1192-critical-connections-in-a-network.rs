impl Solution {
    pub fn critical_connections(n: i32, connections: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for connection in &connections {
            let u = connection[0] as usize;
            let v = connection[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut disc = vec![0; n];
        let mut low = vec![0; n];
        let mut time = 0;
        let mut result = Vec::new();

        fn dfs(
            u: usize,
            parent: usize,
            graph: &Vec<Vec<usize>>,
            visited: &mut Vec<bool>,
            disc: &mut Vec<i32>,
            low: &mut Vec<i32>,
            time: &mut i32,
            result: &mut Vec<Vec<i32>>,
        ) {
            visited[u] = true;
            *time += 1;
            disc[u] = *time;
            low[u] = *time;

            for &v in &graph[u] {
                if !visited[v] {
                    dfs(v, u, graph, visited, disc, low, time, result);
                    low[u] = low[u].min(low[v]);
                    if low[v] > disc[u] {
                        result.push(vec![u as i32, v as i32]);
                    }
                } else if v != parent {
                    low[u] = low[u].min(disc[v]);
                }
            }
        }

        dfs(0, n, &graph, &mut visited, &mut disc, &mut low, &mut time, &mut result);

        result
    }
}