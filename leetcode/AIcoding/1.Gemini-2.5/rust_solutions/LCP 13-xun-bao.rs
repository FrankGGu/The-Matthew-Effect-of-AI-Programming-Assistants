use std::collections::{VecDeque, HashMap};

const INF: i32 = std::i32::MAX;

struct Solution;

impl Solution {
    pub fn get_shortest_path(grid: Vec<Vec<char>>) -> i32 {
        let R = grid.len();
        let C = grid[0].len();

        let mut start_pos = (0, 0);
        let mut mechanisms_pos = Vec::new();
        let mut treasures_pos = Vec::new();

        for r in 0..R {
            for c in 0..C {
                match grid[r][c] {
                    'S' => start_pos = (r, c),
                    'M' => mechanisms_pos.push((r, c)),
                    'T' => treasures_pos.push((r, c)),
                    _ => {}
                }
            }
        }

        let N_M = mechanisms_pos.len();
        let N_T = treasures_pos.len();

        let mut all_key_points = Vec::new();
        all_key_points.push(start_pos);
        all_key_points.extend_from_slice(&mechanisms_pos);
        all_key_points.extend_from_slice(&treasures_pos);
        let K = all_key_points.len();

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        let mut cleared_obstacles_coords: Vec<Vec<(usize, usize)>> = vec![vec![]; N_M];
        for i in 0..N_M {
            let (mr, mc) = mechanisms_pos[i];
            for j in 0..4 {
                let nr = (mr as isize + dr[j]) as usize;
                let nc = (mc as isize + dc[j]) as usize;
                if nr < R && nc < C && grid[nr][nc] == 'O' {
                    cleared_obstacles_coords[i].push((nr, nc));
                }
            }
        }

        let mut min_dist_between_key_points = vec![vec![vec![INF; K]; K]; 1 << N_M];

        for mask in 0..(1 << N_M) {
            let mut current_grid = grid.clone();
            for i in 0..N_M {
                if ((mask >> i) & 1) == 1 {
                    for &(or, oc) in &cleared_obstacles_coords[i] {
                        current_grid[or][oc] = '.';
                    }
                }
            }

            for from_idx in 0..K {
                let (start_r, start_c) = all_key_points[from_idx];
                let mut dist_map = vec![vec![INF; C]; R];
                let mut q = VecDeque::new();

                if current_grid[start_r][start_c] == 'O' {
                    continue; 
                }

                dist_map[start_r][start_c] = 0;
                q.push_back((start_r, start_c, 0));

                while let Some((r, c, d)) = q.pop_front() {
                    for i in 0..4 {
                        let nr = (r as isize + dr[i]) as usize;
                        let nc = (c as isize + dc[i]) as usize;

                        if nr < R && nc < C && current_grid[nr][nc] != 'O' && dist_map[nr][nc] == INF {
                            dist_map[nr][nc] = d + 1;
                            q.push_back((nr, nc, d + 1));
                        }
                    }
                }

                for to_idx in 0..K {
                    let (end_r, end_c) = all_key_points[to_idx];
                    min_dist_between_key_points[mask][from_idx][to_idx] = dist_map[end_r][end_c];
                }
            }
        }

        let mut dp = vec![vec![vec![INF; 1 << N_T]; 1 << N_M]; K];
        let mut q = VecDeque::new();

        dp[0][0][0] = 0;
        q.push_back((0, 0, 0, 0));

        let target_treasure_mask = (1 << N_T) - 1;
        let mut min_total_cost = INF;

        while let Some((cost, u_idx, u_mech_mask, u_treasure_mask)) = q.pop_front() {
            if cost > dp[u_idx][u_mech_mask][u_treasure_mask] {
                continue;
            }

            if u_treasure_mask == target_treasure_mask {
                min_total_cost = min_total_cost.min(cost);
            }

            for v_idx in 0..K {
                if u_idx == v_idx {
                    continue;
                }

                let path_cost = min_dist_between_key_points[u_mech_mask][u_idx][v_idx];
                if path_cost == INF {
                    continue;
                }

                let mut v_mech_mask = u_mech_mask;
                let mut v_treasure_mask = u_treasure_mask;

                if v_idx >= 1 && v_idx < 1 + N_M {
                    let m_actual_idx = v_idx - 1;
                    v_mech_mask |= (1 << m_actual_idx);
                } else if v_idx >= 1 + N_M && v_idx < K {
                    let t_actual_idx = v_idx - (1 + N_M);
                    v_treasure_mask |= (1 << t_actual_idx);
                }

                let new_cost = cost + path_cost;
                if new_cost < dp[v_idx][v_mech_mask][v_treasure_mask] {
                    dp[v_idx][v_mech_mask][v_treasure_mask] = new_cost;
                    q.push_back((new_cost, v_idx, v_mech_mask, v_treasure_mask));
                }
            }
        }

        if min_total_cost == INF {
            -1
        } else {
            min_total_cost
        }
    }
}