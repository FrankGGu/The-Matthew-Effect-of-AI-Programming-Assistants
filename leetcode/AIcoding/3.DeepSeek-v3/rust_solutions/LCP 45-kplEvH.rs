use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn bicycle_yard(position: Vec<i32>, terrain: Vec<Vec<i32>>, obstacle: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = terrain.len();
        let n = terrain[0].len();
        let (x, y) = (position[0] as usize, position[1] as usize);
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((x, y, 1));
        visited.insert((x, y, 1));
        let mut res = HashSet::new();
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j, s)) = queue.pop_front() {
            for (dx, dy) in dirs.iter() {
                let ni = i as i32 + dx;
                let nj = j as i32 + dy;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    let h1 = terrain[i][j];
                    let h2 = terrain[ni][nj];
                    let o = obstacle[ni][nj];
                    let ns = s + h1 - h2 - o;
                    if ns > 0 {
                        if !visited.contains(&(ni, nj, ns)) {
                            visited.insert((ni, nj, ns));
                            queue.push_back((ni, nj, ns));
                            if ns == 1 && (ni != x || nj != y) {
                                res.insert(vec![ni as i32, nj as i32]);
                            }
                        }
                    }
                }
            }
        }

        let mut res: Vec<Vec<i32>> = res.into_iter().collect();
        res.sort();
        res
    }
}