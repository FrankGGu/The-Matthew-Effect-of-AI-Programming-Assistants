use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn largest_path_value(colors: String, edges: Vec<Vec<i32>>) -> i32 {
        let n = colors.len();
        let colors = colors.chars().collect::<Vec<_>>();
        let mut graph = vec![vec![]; n];
        let mut in_degree = vec![0; n];
        let mut color_counts = vec![vec![0; 26]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            in_degree[v] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 0..n {
            if in_degree[i] == 0 {
                queue.push_back(i);
                color_counts[i][(colors[i] as u8 - b'a') as usize] = 1;
            }
        }

        let mut visited = 0;
        let mut max_color = 0;

        while let Some(u) = queue.pop_front() {
            visited += 1;
            let current_max = *color_counts[u].iter().max().unwrap();
            max_color = max_color.max(current_max);

            for &v in &graph[u] {
                for c in 0..26 {
                    let new_count = if c == (colors[v] as u8 - b'a') as usize {
                        color_counts[u][c] + 1
                    } else {
                        color_counts[u][c]
                    };
                    if new_count > color_counts[v][c] {
                        color_counts[v][c] = new_count;
                    }
                }
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    queue.push_back(v);
                }
            }
        }

        if visited == n { max_color } else { -1 }
    }
}