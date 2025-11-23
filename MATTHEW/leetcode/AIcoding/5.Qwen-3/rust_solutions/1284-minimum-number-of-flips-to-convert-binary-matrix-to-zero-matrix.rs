struct Solution;

impl Solution {
    pub fn min_flips(matrix: Vec<Vec<i32>>) -> i32 {
        use std::collections::{HashSet, VecDeque};

        let m = matrix.len();
        let n = matrix[0].len();

        let mut state = 0;
        for i in 0..m {
            for j in 0..n {
                if matrix[i][j] == 1 {
                    state ^= 1 << (i * n + j);
                }
            }
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((state, 0));
        visited.insert(state);

        while let Some((current, steps)) = queue.pop_front() {
            if current == 0 {
                return steps;
            }

            for i in 0..m {
                for j in 0..n {
                    let mut next = current;
                    for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1), (0, 0)] {
                        let x = i as i32 + dx;
                        let y = j as i32 + dy;
                        if x >= 0 && x < m as i32 && y >= 0 && y < n as i32 {
                            next ^= 1 << (x as usize * n + y as usize);
                        }
                    }
                    if !visited.contains(&next) {
                        visited.insert(next);
                        queue.push_back((next, steps + 1));
                    }
                }
            }
        }

        -1
    }
}