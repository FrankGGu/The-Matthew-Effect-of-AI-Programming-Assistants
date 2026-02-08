use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_flips(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut start = 0;
        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 {
                    start |= 1 << (i * n + j);
                }
            }
        }

        let mut queue = VecDeque::new();
        queue.push_back(start);
        let mut visited = HashSet::new();
        visited.insert(start);
        let mut steps = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let current = queue.pop_front().unwrap();
                if current == 0 {
                    return steps;
                }
                for i in 0..m {
                    for j in 0..n {
                        let mut next = current;
                        next ^= 1 << (i * n + j);
                        for &(di, dj) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                            let ni = i as i32 + di;
                            let nj = j as i32 + dj;
                            if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                                next ^= 1 << (ni as usize * n + nj as usize);
                            }
                        }
                        if !visited.contains(&next) {
                            visited.insert(next);
                            queue.push_back(next);
                        }
                    }
                }
            }
            steps += 1;
        }

        -1
    }
}