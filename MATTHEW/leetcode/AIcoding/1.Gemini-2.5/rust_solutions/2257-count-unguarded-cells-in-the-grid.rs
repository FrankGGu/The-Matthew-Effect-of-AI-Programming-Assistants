impl Solution {
    pub fn count_unguarded(m: i32, n: i32, guards: Vec<Vec<i32>>, walls: Vec<Vec<i32>>) -> i32 {
        const EMPTY: i32 = 0;
        const GUARD: i32 = 1;
        const WALL: i32 = 2;
        const GUARDED: i32 = 3;

        let m_usize = m as usize;
        let n_usize = n as usize;

        let mut grid = vec![vec![EMPTY; n_usize]; m_usize];

        for guard_pos in &guards {
            grid[guard_pos[0] as usize][guard_pos[1] as usize] = GUARD;
        }

        for wall_pos in &walls {
            grid[wall_pos[0] as usize][wall_pos[1] as usize] = WALL;
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        for guard_pos in &guards {
            let r_guard = guard_pos[0] as isize;
            let c_guard = guard_pos[1] as isize;

            for (dr, dc) in directions.iter() {
                let mut nr = r_guard + dr;
                let mut nc = c_guard + dc;

                while nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                    let current_r = nr as usize;
                    let current_c = nc as usize;

                    match grid[current_r][current_c] {
                        WALL | GUARD => break,
                        EMPTY => grid[current_r][current_c] = GUARDED,
                        _ => {}
                    }

                    nr += dr;
                    nc += dc;
                }
            }
        }

        let mut unguarded_count = 0;
        for r in 0..m_usize {
            for c in 0..n_usize {
                if grid[r][c] == EMPTY {
                    unguarded_count += 1;
                }
            }
        }

        unguarded_count
    }
}