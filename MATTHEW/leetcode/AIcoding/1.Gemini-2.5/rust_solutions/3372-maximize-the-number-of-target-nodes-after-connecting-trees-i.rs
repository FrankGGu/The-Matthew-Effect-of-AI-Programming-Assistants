struct Solution;

impl Solution {
    pub fn maximize_the_number_of_target_nodes_after_connecting_trees_i(
        n: i32,
        edges: Vec<Vec<i32>>,
        target: Vec<i32>,
    ) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited: Vec<bool> = vec![false; n];
        let mut component_target_counts: Vec<i32> = Vec::new();

        for i in 0..n {
            if !visited[i] {
                let mut current_component_target_count = 0;
                let mut stack: Vec<usize> = Vec::new();
                stack.push(i);
                visited[i] = true;

                while let Some(node) = stack.pop() {
                    if target[node] == 1 {
                        current_component_target_count += 1;
                    }

                    for &neighbor in &adj[node] {
                        if !visited[neighbor] {
                            visited[neighbor] = true;
                            stack.push(neighbor);
                        }
                    }
                }
                component_target_counts.push(current_component_target_count);
            }
        }

        component_target_counts.sort_unstable_by(|a, b| b.cmp(a));

        if component_target_counts.len() <= 1 {
            component_target_counts.get(0).unwrap_or(&0).clone()
        } else {
            component_target_counts[0] + component_target_counts[1]
        }
    }
}