use std::collections::HashSet;

impl Solution {
    pub fn max_target_nodes(edges: Vec<Vec<i32>>, target_nodes: Vec<i32>) -> i32 {
        let mut adj = vec![vec![]; edges.len() + target_nodes.len() + 1];
        let mut in_degree = vec![0; edges.len() + target_nodes.len() + 1];

        for edge in &edges {
            adj[edge[0] as usize].push(edge[1]);
            in_degree[edge[1] as usize] += 1;
        }

        let target_set: HashSet<i32> = target_nodes.iter().cloned().collect();

        let mut visited = vec![false; adj.len()];
        let mut count = 0;

        for i in 1..adj.len() {
            if in_degree[i] == 0 {
                count += Self::dfs(i as i32, &adj, &target_set, &mut visited);
            }
        }

        count
    }

    fn dfs(node: i32, adj: &Vec<Vec<i32>>, target_set: &HashSet<i32>, visited: &mut Vec<bool>) -> i32 {
        if visited[node as usize] {
            return 0;
        }
        visited[node as usize] = true;

        let mut res = 0;
        if target_set.contains(&node) {
            res = 1;
        }

        for &neighbor in &adj[node as usize] {
            res += Self::dfs(neighbor, adj, target_set, visited);
        }

        if res > 0 && target_set.contains(&node) {
            return 1;
        } else if res > 0 {
            return 0;
        } else if target_set.contains(&node){
            return 1;
        }
        else {
            return 0;
        }
    }
}