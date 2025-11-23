use std::collections::VecDeque;

impl Solution {
    pub fn is_bipartite(graph: Vec<Vec<i32>>) -> bool {
        let n = graph.len();
        if n == 0 {
            return true;
        }

        let mut colors: Vec<i32> = vec![0; n]; // 0: uncolored, 1: color A, 2: color B

        for i in 0..n {
            if colors[i] == 0 {
                let mut q: VecDeque<usize> = VecDeque::new();
                q.push_back(i);
                colors[i] = 1;

                while let Some(u) = q.pop_front() {
                    let current_color = colors[u];
                    let neighbor_color = if current_color == 1 { 2 } else { 1 };

                    for &v_idx in graph[u].iter() {
                        let v = v_idx as usize;
                        if colors[v] == 0 {
                            colors[v] = neighbor_color;
                            q.push_back(v);
                        } else if colors[v] == current_color {
                            return false;
                        }
                    }
                }
            }
        }

        true
    }
}