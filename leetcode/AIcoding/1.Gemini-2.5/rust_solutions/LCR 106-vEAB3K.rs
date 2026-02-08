use std::collections::VecDeque;

impl Solution {
    pub fn is_bipartite(graph: Vec<Vec<i32>>) -> bool {
        let n = graph.len();
        if n == 0 {
            return true;
        }

        // 0: uncolored, 1: color A, -1: color B
        let mut colors = vec![0; n];

        for i in 0..n {
            // If node i is uncolored, start a BFS from it
            if colors[i] == 0 {
                let mut queue = VecDeque::new();
                queue.push_back(i);
                colors[i] = 1; // Assign initial color A to the starting node

                while let Some(u) = queue.pop_front() {
                    let current_color = colors[u];
                    let neighbor_color = -current_color; // Opposite color for neighbors

                    for &v_i32 in graph[u].iter() {
                        let v = v_i32 as usize; // Convert neighbor index to usize

                        if colors[v] == 0 {
                            // Neighbor is uncolored, assign opposite color and enqueue
                            colors[v] = neighbor_color;
                            queue.push_back(v);
                        } else if colors[v] == current_color {
                            // Neighbor has the same color, not bipartite
                            return false;
                        }
                        // If colors[v] == neighbor_color, it's already correctly colored, do nothing.
                    }
                }
            }
        }

        true
    }
}