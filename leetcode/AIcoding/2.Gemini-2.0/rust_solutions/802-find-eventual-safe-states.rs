impl Solution {
    pub fn eventual_safe_nodes(graph: Vec<Vec<i32>>) -> Vec<i32> {
        let n = graph.len();
        let mut colors = vec![0; n]; // 0: unvisited, 1: visiting, 2: visited (safe)
        let mut safe_nodes = Vec::new();

        fn dfs(node: usize, graph: &Vec<Vec<i32>>, colors: &mut Vec<i32>) -> bool {
            if colors[node] == 1 {
                return false; // Cycle detected
            }
            if colors[node] == 2 {
                return true; // Already visited and safe
            }

            colors[node] = 1; // Mark as visiting

            for &neighbor in &graph[node] {
                if !dfs(neighbor as usize, graph, colors) {
                    return false;
                }
            }

            colors[node] = 2; // Mark as visited (safe)
            true
        }

        for i in 0..n {
            if dfs(i, &graph, &mut colors) {
                safe_nodes.push(i as i32);
            }
        }

        safe_nodes.sort();
        safe_nodes
    }
}