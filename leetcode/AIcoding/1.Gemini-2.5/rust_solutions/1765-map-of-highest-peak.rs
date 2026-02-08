use std::collections::VecDeque;

impl Solution {
    pub fn highest_peak(is_water: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = is_water.len();
        let n = is_water[0].len();

        let mut result = vec![vec![-1; n]; m];
        let mut queue = VecDeque::new();

        for r in 0..m {
            for c in 0..n {
                if is_water[r][c] == 1 {
                    result[r][c] = 0;
                    queue.push_back((r as i32, c as i32));
                }
            }
        }

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c)) = queue.pop_front() {
            for i in 0..4 {
                let nr = r + dr[i];
                let nc = c + dc[i];

                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr_usize = nr as usize;
                    let nc_usize = nc as usize;
                    if result[nr_usize][nc_usize] == -1 {
                        result[nr_usize][nc_usize] = result[r as usize][c as usize] + 1;
                        queue.push_back((nr, nc));
                    }
                }
            }
        }

        result
    }
}