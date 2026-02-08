impl Solution {
    pub fn count_visited_nodes(edges: Vec<i32>) -> Vec<i32> {
        let n = edges.len();
        let mut ans = vec![0; n];
        let mut visited_state = vec![0; n]; // 0: unvisited, 1: visiting (in current path), 2: visited (ans computed)
        let mut path_stack = Vec::with_capacity(n); // Stores nodes in current DFS path

        for i in 0..n {
            if ans[i] == 0 { // If this node hasn't been processed yet
                path_stack.clear();
                let mut curr = i;

                // Traverse until we hit an already visited node
                while visited_state[curr] == 0 {
                    visited_state[curr] = 1; // Mark as visiting
                    path_stack.push(curr);
                    curr = edges[curr] as usize;
                }

                // Now `curr` is either in the current path (cycle) or already processed (leads to known part)

                if visited_state[curr] == 1 { // Cycle detected
                    // `curr` is the first node of the cycle in the current path
                    let mut cycle_start_idx = 0;
                    for j in 0..path_stack.len() {
                        if path_stack[j] == curr {
                            cycle_start_idx = j;
                            break;
                        }
                    }
                    let cycle_len = (path_stack.len() - cycle_start_idx) as i32;

                    // Assign cycle_len to all nodes in the cycle
                    for j in cycle_start_idx..path_stack.len() {
                        let node_in_cycle = path_stack[j];
                        ans[node_in_cycle] = cycle_len;
                        visited_state[node_in_cycle] = 2; // Mark as fully processed
                    }

                    // For nodes leading into the cycle (before `cycle_start_idx` in `path_stack`)
                    // Their count is `ans[next_node] + 1`
                    for j in (0..cycle_start_idx).rev() {
                        let node = path_stack[j];
                        ans[node] = ans[edges[node] as usize] + 1;
                        visited_state[node] = 2; // Mark as fully processed
                    }

                } else { // visited_state[curr] == 2, meaning `curr` is already processed and `ans[curr]` is known
                    // Propagate counts backwards from `curr` up the current `path_stack`
                    for j in (0..path_stack.len()).rev() {
                        let node = path_stack[j];
                        // If ans[node] is still 0, it means it's part of the path leading to `curr`
                        // and its value hasn't been set by a cycle or previous processing.
                        if ans[node] == 0 {
                             ans[node] = ans[edges[node] as usize] + 1;
                             visited_state[node] = 2; // Mark as fully processed
                        } else {
                            // This node was already processed (e.g., part of a cycle that `curr` was part of)
                            // or part of a path that was already processed.
                            // All preceding nodes in path_stack should also have been computed, so we can break.
                            break;
                        }
                    }
                }
            }
        }
        ans
    }
}