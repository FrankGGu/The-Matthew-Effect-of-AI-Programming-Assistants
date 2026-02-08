use std::collections::VecDeque;

impl Solution {
    pub fn min_flips(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let start = (0..m)
            .flat_map(|i| (0..n).map(move |j| (i, j)))
            .filter(|&(i, j)| grid[i][j] == 1)
            .enumerate()
            .map(|(k, _)| 1 << k)
            .sum::<i32>();
        let target = if (m * n) % 2 == 0 {
            0
        } else {
            1 << ((m * n) / 2)
        };
        let mut queue = VecDeque::new();
        queue.push_back((start, 0));
        let mut visited = std::collections::HashSet::new();
        visited.insert(start);

        while let Some((curr, steps)) = queue.pop_front() {
            if curr == target {
                return steps;
            }

            for i in 0..(m * n) {
                let mut next = curr;
                let row = i / n;
                let col = i % n;
                let mirror_row = m - 1 - row;
                let mirror_col = n - 1 - col;
                let mirror_idx = mirror_row * n + mirror_col;

                if (curr & (1 << i)) != 0 {
                    next ^= (1 << i);
                } else {
                    next |= (1 << i);
                }

                if i != mirror_idx {
                    if (curr & (1 << mirror_idx)) != 0 {
                        next ^= (1 << mirror_idx);
                    } else {
                        next |= (1 << mirror_idx);
                    }
                }
                if !visited.contains(&next) {
                    visited.insert(next);
                    queue.push_back((next, steps + 1));
                }
            }
        }

        -1
    }
}

struct Solution;