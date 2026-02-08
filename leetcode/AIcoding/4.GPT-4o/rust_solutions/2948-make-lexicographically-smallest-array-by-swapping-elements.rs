impl Solution {
    pub fn smallest_swap(arr: Vec<i32>, swaps: Vec<Vec<i32>>) -> Vec<i32> {
        use std::collections::HashSet;

        let n = arr.len();
        let mut graph = vec![Vec::new(); n];

        for swap in swaps {
            let u = swap[0] as usize;
            let v = swap[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut result = arr.clone();

        for i in 0..n {
            if !visited[i] {
                let mut components = Vec::new();
                let mut indices = Vec::new();

                let mut stack = vec![i];
                while let Some(node) = stack.pop() {
                    if !visited[node] {
                        visited[node] = true;
                        components.push(arr[node]);
                        indices.push(node);

                        for &neigh in &graph[node] {
                            if !visited[neigh] {
                                stack.push(neigh);
                            }
                        }
                    }
                }

                components.sort();
                indices.sort();

                for j in 0..components.len() {
                    result[indices[j]] = components[j];
                }
            }
        }

        result
    }
}