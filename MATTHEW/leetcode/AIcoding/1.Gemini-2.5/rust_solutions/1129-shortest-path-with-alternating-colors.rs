use std::collections::VecDeque;

impl Solution {
    pub fn shortest_alternating_paths(n: i32, red_edges: Vec<Vec<i32>>, blue_edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;

        let mut adj: Vec<Vec<Vec<i32>>> = vec![vec![vec![]; 2]; n];
        for edge in red_edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u][0].push(v as i32); // 0 for red
        }
        for edge in blue_edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u][1].push(v as i32); // 1 for blue
        }

        // dist[node][color_of_last_edge] stores the shortest path length
        // 0 for red, 1 for blue
        let mut dist: Vec<Vec<i32>> = vec![vec![i32::MAX; 2]; n];

        let mut q: VecDeque<(usize, i32)> = VecDeque::new(); // (node, color_of_last_edge_used)

        // Initialize for node 0. It can be reached with path length 0, effectively starting with either color.
        dist[0][0] = 0;
        dist[0][1] = 0;
        q.push_back((0, 0)); // Arrived at node 0 via a conceptual red edge (length 0)
        q.push_back((0, 1)); // Arrived at node 0 via a conceptual blue edge (length 0)

        while let Some((u, prev_color)) = q.pop_front() {
            let d = dist[u][prev_color as usize];
            let next_color = 1 - prev_color; // Alternate color

            for &v_i32 in adj[u][next_color as usize].iter() {
                let v = v_i32 as usize;
                if d + 1 < dist[v][next_color as usize] {
                    dist[v][next_color as usize] = d + 1;
                    q.push_back((v, next_color));
                }
            }
        }

        let mut ans: Vec<i32> = vec![-1; n];
        for i in 0..n {
            let min_d = dist[i][0].min(dist[i][1]);
            if min_d != i32::MAX {
                ans[i] = min_d;
            }
        }

        ans
    }
}