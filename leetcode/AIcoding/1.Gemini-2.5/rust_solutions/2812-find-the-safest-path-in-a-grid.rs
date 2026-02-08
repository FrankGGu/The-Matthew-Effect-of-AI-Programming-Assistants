use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn maximum_safeness_factor(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();

        let mut dist_to_thief = vec![vec![i32::MAX; n]; n];
        let mut q_bfs: VecDeque<(usize, usize)> = VecDeque::new();

        for r in 0..n {
            for c in 0..n {
                if grid[r][c] == 1 {
                    dist_to_thief[r][c] = 0;
                    q_bfs.push_back((r, c));
                }
            }
        }

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c)) = q_bfs.pop_front() {
            let current_dist = dist_to_thief[r][c];

            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr >= 0 && nr < n as i32 && nc >= 0 && nc < n as i32 {
                    let nr_usize = nr as usize;
                    let nc_usize = nc as usize;
                    if dist_to_thief[nr_usize][nc_usize] > current_dist + 1 {
                        dist_to_thief[nr_usize][nc_usize] = current_dist + 1;
                        q_bfs.push_back((nr_usize, nc_usize));
                    }
                }
            }
        }

        let mut low = 0;
        let mut high = 0;
        for r in 0..n {
            for c in 0..n {
                high = high.max(dist_to_thief[r][c]);
            }
        }

        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::can_reach(mid, n, &dist_to_thief) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        ans
    }

    fn can_reach(k: i32, n: usize, dist_to_thief: &Vec<Vec<i32>>) -> bool {
        if dist_to_thief[0][0] < k || dist_to_thief[n - 1][n - 1] < k {
            return false;
        }

        let mut q: VecDeque<(usize, usize)> = VecDeque::new();
        let mut visited = vec![vec![false; n]; n];

        q.push_back((0, 0));
        visited[0][0] = true;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c)) = q.pop_front() {
            if r == n - 1 && c == n - 1 {
                return true;
            }

            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr >= 0 && nr < n as i32 && nc >= 0 && nc < n as i32 {
                    let nr_usize = nr as usize;
                    let nc_usize = nc as usize;
                    if !visited[nr_usize][nc_usize] && dist_to_thief[nr_usize][nc_usize] >= k {
                        visited[nr_usize][nc_usize] = true;
                        q.push_back((nr_usize, nc_usize));
                    }
                }
            }
        }

        false
    }
}