use std::collections::HashMap;

impl Solution {
    pub fn count_components(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in edges {
            graph.entry(edge[0]).or_insert(vec![]).push(edge[1]);
            graph.entry(edge[1]).or_insert(vec![]).push(edge[0]);
        }

        let mut visited = vec![false; n as usize];
        let mut count = 0;

        for i in 0..n {
            if !visited[i as usize] {
                count += 1;
                Self::dfs(i, &graph, &mut visited);
            }
        }

        count
    }

    fn dfs(node: i32, graph: &HashMap<i32, Vec<i32>>, visited: &mut Vec<bool>) {
        visited[node as usize] = true;
        if let Some(neighbors) = graph.get(&node) {
            for &neighbor in neighbors {
                if !visited[neighbor as usize] {
                    Self::dfs(neighbor, graph, visited);
                }
            }
        }
    }
}