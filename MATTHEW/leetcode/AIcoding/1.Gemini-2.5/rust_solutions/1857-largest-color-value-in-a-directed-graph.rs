use std::collections::VecDeque;

impl Solution {
    pub fn largest_path_value(colors: String, edges: Vec<Vec<i32>>) -> i32 {
        let n = colors.len();
        let colors_bytes = colors.as_bytes();

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut in_degree: Vec<i32> = vec![0; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            in_degree[v] += 1;
        }

        // dp[i][j] stores the maximum count of character 'a'+j on any path ending at node i.
        let mut dp: Vec<Vec<i32>> = vec![vec![0; 26]; n];
        let mut q: VecDeque<usize> = VecDeque::new();

        // Initialize queue with all nodes having an in-degree of 0 (source nodes).
        for i in 0..n {
            if in_degree[i] == 0 {
                q.push_back(i);
            }
        }

        let mut nodes_visited_count = 0;
        let mut max_color_value = 0;

        while let Some(u) = q.pop_front() {
            nodes_visited_count += 1;

            // Increment count for the color of the current node u
            let color_idx = (colors_bytes[u] - b'a') as usize;
            dp[u][color_idx] += 1;

            // Update max_color_value with the current node's color counts
            for &count in dp[u].iter() {
                max_color_value = max_color_value.max(count);
            }

            // Propagate counts to neighbors
            for &v in &adj[u] {
                for c in 0..26 {
                    dp[v][c] = dp[v][c].max(dp[u][c]);
                }
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    q.push_back(v);
                }
            }
        }

        // If not all nodes were visited, there's a cycle.
        if nodes_visited_count < n {
            -1
        } else {
            max_color_value
        }
    }
}