use std::collections::{VecDeque, HashSet};

struct Solution;

impl Solution {
    pub fn min_flips(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();

        let mut initial_state = 0;
        for r in 0..m {
            for c in 0..n {
                if mat[r][c] == 1 {
                    initial_state |= 1 << (r * n + c);
                }
            }
        }

        let mut queue = VecDeque::new();
        queue.push_back((initial_state, 0));

        let mut visited = HashSet::new();
        visited.insert(initial_state);

        while let Some((current_state, num_flips)) = queue.pop_front() {
            if current_state == 0 {
                return num_flips;
            }

            for r in 0..m {
                for c in 0..n {
                    let mut next_state = current_state;

                    next_state ^= 1 << (r * n + c);

                    let dr = [-1, 1, 0, 0];
                    let dc = [0, 0, -1, 1];

                    for i in 0..4 {
                        let nr = r as isize + dr[i];
                        let nc = c as isize + dc[i];

                        if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                            next_state ^= 1 << (nr as usize * n + nc as usize);
                        }
                    }

                    if visited.insert(next_state) {
                        queue.push_back((next_state, num_flips + 1));
                    }
                }
            }
        }

        -1
    }
}