use std::collections::VecDeque;

impl Solution {
    pub fn min_flips(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();

        let mut start = 0;
        for i in 0..m {
            for j in 0..n {
                start |= (mat[i][j] << (i * n + j)) as i32;
            }
        }

        let mut q = VecDeque::new();
        q.push_back(start);

        let mut visited = std::collections::HashSet::new();
        visited.insert(start);

        let mut steps = 0;
        while !q.is_empty() {
            let size = q.len();
            for _ in 0..size {
                let curr = q.pop_front().unwrap();
                if curr == 0 {
                    return steps;
                }

                for i in 0..m {
                    for j in 0..n {
                        let mut next = curr;
                        next ^= (1 << (i * n + j)) as i32;
                        if i > 0 {
                            next ^= (1 << ((i - 1) * n + j)) as i32;
                        }
                        if i < m - 1 {
                            next ^= (1 << ((i + 1) * n + j)) as i32;
                        }
                        if j > 0 {
                            next ^= (1 << (i * n + (j - 1))) as i32;
                        }
                        if j < n - 1 {
                            next ^= (1 << (i * n + (j + 1))) as i32;
                        }

                        if !visited.contains(&next) {
                            visited.insert(next);
                            q.push_back(next);
                        }
                    }
                }
            }
            steps += 1;
        }

        -1
    }
}