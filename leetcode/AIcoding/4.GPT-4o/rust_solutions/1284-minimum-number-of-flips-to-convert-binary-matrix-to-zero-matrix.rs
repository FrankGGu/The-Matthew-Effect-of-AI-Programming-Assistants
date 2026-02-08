impl Solution {
    pub fn min_flips(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut initial = 0;

        for i in 0..m {
            for j in 0..n {
                initial |= (mat[i][j] << (i * n + j));
            }
        }

        let mut queue = std::collections::VecDeque::new();
        let mut visited = std::collections::HashSet::new();
        queue.push_back(initial);
        visited.insert(initial);
        let mut flips = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let current = queue.pop_front().unwrap();
                if current == 0 {
                    return flips;
                }
                for i in 0..m {
                    for j in 0..n {
                        let next = flip(current, i, j, n);
                        if visited.insert(next) {
                            queue.push_back(next);
                        }
                    }
                }
            }
            flips += 1;
        }

        -1
    }
}

fn flip(num: i32, i: usize, j: usize, n: usize) -> i32 {
    let idx = i * n + j;
    let mut mask = 1 << idx;
    let directions = [(0, 0), (0, 1), (1, 0), (0, -1), (-1, 0)];

    for (dx, dy) in directions.iter() {
        let ni = i as isize + dx;
        let nj = j as isize + dy;
        if ni >= 0 && ni < m as isize && nj >= 0 && nj < n as isize {
            let neighbor_idx = ni as usize * n + nj as usize;
            mask ^= 1 << neighbor_idx;
        }
    }
    num ^ mask
}