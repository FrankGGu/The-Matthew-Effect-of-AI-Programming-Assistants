use std::collections::VecDeque;

impl Solution {
    pub fn possible_bipartition(n: i32, dislikes: Vec<Vec<i32>>) -> bool {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n_usize + 1];
        for dislike in dislikes {
            let u = dislike[0];
            let v = dislike[1];
            adj[u as usize].push(v);
            adj[v as usize].push(u);
        }

        let mut colors: Vec<i32> = vec![0; n_usize + 1]; // 0: uncolored, 1: color A, 2: color B

        for i in 1..=n_usize {
            if colors[i] == 0 {
                // Node i is uncolored, start BFS
                let mut q: VecDeque<i32> = VecDeque::new();
                q.push_back(i as i32);
                colors[i] = 1; // Assign initial color A

                while let Some(u) = q.pop_front() {
                    let current_color = colors[u as usize];
                    let next_color = 3 - current_color; // Opposite color

                    for &v in &adj[u as usize] {
                        if colors[v as usize] == 0 {
                            // Neighbor v is uncolored, assign opposite color and add to queue
                            colors[v as usize] = next_color;
                            q.push_back(v);
                        } else if colors[v as usize] == current_color {
                            // Neighbor v has the same color as u, not bipartite
                            return false;
                        }
                        // If colors[v] == next_color, it's consistent, do nothing.
                    }
                }
            }
        }

        true
    }
}