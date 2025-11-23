struct Solution {}

impl Solution {
    pub fn count_unreachable_pairs(n: i32, edges: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited: Vec<bool> = vec![false; n];
        let mut components: Vec<usize> = Vec::new();

        for i in 0..n {
            if !visited[i] {
                let mut count = 0;
                let mut stack: Vec<usize> = vec![i];
                visited[i] = true;

                while let Some(node) = stack.pop() {
                    count += 1;
                    for &neighbor in &adj[node] {
                        if !visited[neighbor] {
                            visited[neighbor] = true;
                            stack.push(neighbor);
                        }
                    }
                }
                components.push(count);
            }
        }

        let mut unreachable_pairs: i64 = 0;
        let mut remaining_nodes: usize = n;

        for &component_size in &components {
            unreachable_pairs += (component_size as i64) * ((remaining_nodes - component_size) as i64);
            remaining_nodes -= component_size;
        }

        unreachable_pairs
    }
}