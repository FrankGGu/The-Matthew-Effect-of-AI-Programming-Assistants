use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn minimum_jumps(forbidden: Vec<i32>, a: i32, b: i32, x: i32) -> i32 {
        // A safe upper bound for the position to consider.
        // The maximum coordinate x can be is 2000. a and b can be up to 2000.
        // In the worst case, to reach x, we might need to overshoot it and come back.
        // A common upper bound for such problems is roughly max(x, max_forbidden_val) + a + b.
        // Given constraints, this could be around 2000 + 2000 + 2000 = 6000.
        // Let's use 6000 as a sufficiently large upper bound for positions to visit.
        const MAX_POS: i32 = 6000; 

        let forbidden_set: HashSet<i32> = forbidden.into_iter().collect();

        // visited[pos][0] means we have visited 'pos' with the last jump being a forward jump (or initial state)
        // visited[pos][1] means we have visited 'pos' with the last jump being a backward jump
        let mut visited: Vec<Vec<bool>> = vec![vec![false; 2]; (MAX_POS + 1) as usize];

        // Queue stores (current_pos, last_jump_was_backward, jumps_count)
        let mut queue: VecDeque<(i32, bool, i32)> = VecDeque::new(); 

        // Initial state: start at 0, last jump was not backward (initial state), 0 jumps
        queue.push_back((0, false, 0));
        visited[0 as usize][0] = true; // Mark 0 as visited from a "forward" state
        visited[0 as usize][1] = true; // Mark 0 as visited from a "backward" state (prevents unnecessary re-visits if 0 is reached via backward jump)

        while let Some((curr_pos, last_jump_was_backward, jumps)) = queue.pop_front() {
            if curr_pos == x {
                return jumps;
            }

            // Try jumping forward
            let next_pos_f = curr_pos + a;
            if next_pos_f <= MAX_POS 
                && !forbidden_set.contains(&next_pos_f) 
                && !visited[next_pos_f as usize][0] {

                visited[next_pos_f as usize][0] = true;
                queue.push_back((next_pos_f, false, jumps + 1));
            }

            // Try jumping backward
            // Cannot jump backward twice in a row, and cannot jump to negative positions
            let next_pos_b = curr_pos - b;
            if !last_jump_was_backward 
                && next_pos_b >= 0 
                && !forbidden_set.contains(&next_pos_b) 
                && !visited[next_pos_b as usize][1] {

                visited[next_pos_b as usize][1] = true;
                queue.push_back((next_pos_b, true, jumps + 1));
            }
        }

        -1 // If x is not reachable
    }
}