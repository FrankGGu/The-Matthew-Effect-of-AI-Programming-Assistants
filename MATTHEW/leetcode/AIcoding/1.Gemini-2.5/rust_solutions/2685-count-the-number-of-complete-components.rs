impl Solution {
    pub fn count_complete_components(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited: Vec<bool> = vec![false; n];
        let mut complete_components_count = 0;

        for i in 0..n {
            if !visited[i] {
                let mut current_component_nodes_count = 0;
                let mut component_nodes_list: Vec<usize> = Vec::new();
                let mut stack: Vec<usize> = Vec::new();

                stack.push(i);
                visited[i] = true;

                while let Some(u) = stack.pop() {
                    current_component_nodes_count += 1;
                    component_nodes_list.push(u);

                    for &v in &adj[u] {
                        if !visited[v] {
                            visited[v] = true;
                            stack.push(v);
                        }
                    }
                }

                let mut is_complete = true;
                if current_component_nodes_count > 0 {
                    let expected_degree = current_component_nodes_count - 1;
                    for &node_idx in &component_nodes_list {
                        if adj[node_idx].len() != expected_degree {
                            is_complete = false;
                            break;
                        }
                    }
                } else {
                    is_complete = true;
                }

                if is_complete {
                    complete_components_count += 1;
                }
            }
        }

        complete_components_count
    }
}