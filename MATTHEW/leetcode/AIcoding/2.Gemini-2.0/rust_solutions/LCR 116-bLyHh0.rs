struct Solution {}

impl Solution {
    pub fn find_circle_num(isConnected: Vec<Vec<i32>>) -> i32 {
        let n = isConnected.len();
        let mut visited = vec![false; n];
        let mut count = 0;

        fn dfs(graph: &Vec<Vec<i32>>, visited: &mut Vec<bool>, node: usize) {
            visited[node] = true;
            for i in 0..graph.len() {
                if graph[node][i] == 1 && !visited[i] {
                    dfs(graph, visited, i);
                }
            }
        }

        for i in 0..n {
            if !visited[i] {
                dfs(&isConnected, &mut visited, i);
                count += 1;
            }
        }

        count
    }
}