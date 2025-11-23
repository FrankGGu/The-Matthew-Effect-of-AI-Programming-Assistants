use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn maximum_minutes(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut fire_time = vec![vec![i32::MAX; n]; m];
        let mut q_fire = VecDeque::new();

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    fire_time[r][c] = 0;
                    q_fire.push_back((r, c, 0));
                }
            }
        }

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c, t)) = q_fire.pop_front() {
            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    if grid[nr][nc] != 2 && fire_time[nr][nc] == i32::MAX {
                        fire_time[nr][nc] = t + 1;
                        q_fire.push_back((nr, nc, t + 1));
                    }
                }
            }
        }

        let can_reach_safe_house = |wait_time: i32, fire_time: &Vec<Vec<i32>>, grid: &Vec<Vec<i32>>| -> bool {
            if fire_time[0][0] != i32::MAX && wait_time >= fire_time[0][0] {
                return false;
            }

            let mut player_time = vec![vec![i32::MAX; n]; m];
            let mut q_player = VecDeque::new();

            player_time[0][0] = wait_time;
            q_player.push_back((0, 0, wait_time));

            while let Some((r, c, t)) = q_player.pop_front() {
                if r == m - 1 && c == n - 1 {
                    return true;
                }

                for i in 0..4 {
                    let nr = r as i32 + dr[i];
                    let nc = c as i32 + dc[i];

                    if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                        let nr = nr as usize;
                        let nc = nc as usize;

                        if grid[nr][nc] != 2 && player_time[nr][nc] == i32::MAX {
                            let next_player_arrival_time = t + 1;

                            let safe_condition = if nr == m - 1 && nc == n - 1 {
                                next_player_arrival_time <= fire_time[nr][nc]
                            } else {
                                next_player_arrival_time < fire_time[nr][nc]
                            };

                            if safe_condition {
                                player_time[nr][nc] = next_player_arrival_time;
                                q_player.push_back((nr, nc, next_player_arrival_time));
                            }
                        }
                    }
                }
            }
            false
        };

        let mut low = 0;
        let mut high = 2_000_000_000;
        let mut ans = -1;

        while low <= high {
            let mid = low + (high - low) / 2;
            if can_reach_safe_house(mid, &fire_time, &grid) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        ans
    }
}