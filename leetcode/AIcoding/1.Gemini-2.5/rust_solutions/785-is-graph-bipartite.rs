use std::collections::VecDeque;

impl Solution {
    pub fn is_bipartite(graph: Vec<Vec<i32>>) -> bool {
        let n = graph.len();
        if n == 0 {
            return true;
        }

        let mut colors: Vec<i32> = vec![-1; n]; // -1: uncolored, 0: color A, 1: color B

        for i in 0..n {
            if colors[i] == -1 { // If node i is uncolored, start a BFS/DFS from it
                let mut queue: VecDeque<usize> = VecDeque::new();
                queue.push_back(i);
                colors[i] = 0; // Assign initial color A

                while let Some(u) = queue.pop_front() {
                    for &v_idx in graph[u].iter() {
                        let v = v_idx as usize;
                        if colors[v] == -1 { // Neighbor v is uncolored
                            colors[v] = 1 - colors[u]; // Assign opposite color
                            queue.push_back(v);
                        } else if colors[v] == colors[u] { // Neighbor v has the same color, conflict!
                            return false;
                        }
                    }
                }
            }
        }

        true
    }
}