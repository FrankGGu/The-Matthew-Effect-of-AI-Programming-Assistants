use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn shortest_path_length(graph: Vec<Vec<i32>>) -> i32 {
        let n = graph.len();
        if n == 1 {
            return 0;
        }

        let all_visited_mask = (1 << n) - 1;
        let mut q: VecDeque<(i32, i32, i32)> = VecDeque::new(); // (node, mask, distance)
        let mut visited: HashSet<(i32, i32)> = HashSet::new(); // (node, mask)

        for i in 0..n {
            let initial_mask = 1 << i;
            q.push_back((i as i32, initial_mask, 0));
            visited.insert((i as i32, initial_mask));
        }

        while let Some((u, mask, dist)) = q.pop_front() {
            if mask == all_visited_mask {
                return dist;
            }

            for &v_node_idx in graph[u as usize].iter() {
                let new_mask = mask | (1 << v_node_idx);
                if !visited.contains(&(v_node_idx, new_mask)) {
                    visited.insert((v_node_idx, new_mask));
                    q.push_back((v_node_idx, new_mask, dist + 1));
                }
            }
        }

        unreachable!()
    }
}