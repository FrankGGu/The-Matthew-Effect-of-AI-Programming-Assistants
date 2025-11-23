use std::collections::HashSet;

impl Solution {
    pub fn make_connected(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        if connections.len() < (n - 1) as usize {
            return -1;
        }

        let mut graph = vec![vec![]; n as usize];
        for conn in connections {
            graph[conn[0] as usize].push(conn[1]);
            graph[conn[1] as usize].push(conn[0]);
        }

        let mut visited = HashSet::new();
        let mut components = 0;

        for i in 0..n {
            if !visited.contains(&i) {
                components += 1;
                Self::dfs(i, &graph, &mut visited);
            }
        }

        components - 1
    }

    fn dfs(node: i32, graph: &Vec<Vec<i32>>, visited: &mut HashSet<i32>) {
        visited.insert(node);
        for &neighbor in &graph[node as usize] {
            if !visited.contains(&neighbor) {
                Self::dfs(neighbor, graph, visited);
            }
        }
    }
}