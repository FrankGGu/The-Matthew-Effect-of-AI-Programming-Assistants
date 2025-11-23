use std::collections::VecDeque;

impl Solution {
    pub fn can_reach(arr: Vec<i32>, start: i32) -> bool {
        let n = arr.len();
        let mut visited = vec![false; n];
        let mut q = VecDeque::new();

        q.push_back(start as usize);
        visited[start as usize] = true;

        while let Some(curr_idx) = q.pop_front() {
            if arr[curr_idx] == 0 {
                return true;
            }

            let jump_val = arr[curr_idx];

            // Jump forward
            let next_forward = curr_idx as i32 + jump_val;
            if next_forward >= 0 && next_forward < n as i32 {
                let next_forward_idx = next_forward as usize;
                if !visited[next_forward_idx] {
                    visited[next_forward_idx] = true;
                    q.push_back(next_forward_idx);
                }
            }

            // Jump backward
            let next_backward = curr_idx as i32 - jump_val;
            if next_backward >= 0 && next_backward < n as i32 {
                let next_backward_idx = next_backward as usize;
                if !visited[next_backward_idx] {
                    visited[next_backward_idx] = true;
                    q.push_back(next_backward_idx);
                }
            }
        }

        false
    }
}