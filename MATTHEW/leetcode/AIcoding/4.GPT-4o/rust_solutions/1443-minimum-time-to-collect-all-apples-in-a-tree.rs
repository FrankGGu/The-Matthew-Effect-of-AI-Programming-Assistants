impl Solution {
    pub fn min_time(n: i32, edges: Vec<Vec<i32>>, has_apples: Vec<bool>) -> i32 {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }
        fn dfs(node: usize, parent: usize, graph: &Vec<Vec<i32>>, has_apples: &Vec<bool>) -> i32 {
            let mut time = 0;
            for &neighbor in &graph[node] {
                if neighbor != parent {
                    time += dfs(neighbor as usize, node, graph, has_apples);
                }
            }
            if (time > 0 || has_apples[node]) && node != 0 {
                time += 2;
            }
            time
        }
        dfs(0, -1, &graph, &has_apples)
    }
}