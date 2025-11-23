impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn maximum_minutes(grid: Vec<Vec<i32>>) -> i32 {
        let (rows, cols) = (grid.len(), grid[0].len());
        let mut fire_q = VecDeque::new();
        let mut person_q = VecDeque::new();

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    fire_q.push_back((i, j));
                } else if grid[i][j] == 2 {
                    person_q.push_back((i, j));
                }
            }
        }

        let mut fire_time = vec![vec![-1; cols]; rows];
        let mut person_time = vec![vec![-1; cols]; rows];

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        let mut fire_visited = HashSet::new();
        while let Some((r, c)) = fire_q.pop_front() {
            if fire_time[r][c] != -1 {
                continue;
            }
            fire_time[r][c] = 0;
            fire_visited.insert((r, c));
            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    let (nr, nc) = (nr as usize, nc as usize);
                    if grid[nr][nc] == 0 && !fire_visited.contains(&(nr, nc)) {
                        fire_time[nr][nc] = 0;
                        fire_q.push_back((nr, nc));
                    }
                }
            }
        }

        let mut person_visited = HashSet::new();
        while let Some((r, c)) = person_q.pop_front() {
            if person_time[r][c] != -1 {
                continue;
            }
            person_time[r][c] = 0;
            person_visited.insert((r, c));
            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    let (nr, nc) = (nr as usize, nc as usize);
                    if grid[nr][nc] == 0 && !person_visited.contains(&(nr, nc)) {
                        person_time[nr][nc] = 0;
                        person_q.push_back((nr, nc));
                    }
                }
            }
        }

        let mut max_time = -1;
        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 0 && person_time[i][j] != -1 {
                    let person_t = person_time[i][j];
                    let fire_t = fire_time[i][j];
                    if fire_t == -1 {
                        max_time = std::cmp::max(max_time, person_t);
                    } else {
                        if person_t < fire_t {
                            max_time = std::cmp::max(max_time, person_t);
                        } else if person_t == fire_t {
                            let is_safe = check_escape(&grid, i, j, person_t, fire_time);
                            if is_safe {
                                max_time = std::cmp::max(max_time, person_t);
                            }
                        }
                    }
                }
            }
        }

        if max_time == -1 {
            return -1;
        }

        max_time
    }

    fn check_escape(grid: &Vec<Vec<i32>>, row: usize, col: usize, time: i32, fire_time: &Vec<Vec<i32>>) -> bool {
        let (rows, cols) = (grid.len(), grid[0].len());
        let mut visited = vec![vec![false; cols]; rows];
        let mut q = VecDeque::new();
        q.push_back((row, col));
        visited[row][col] = true;

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        let mut t = 0;
        while let Some((r, c)) = q.pop_front() {
            if t > time {
                return false;
            }
            if r == 0 || r == rows - 1 || c == 0 || c == cols - 1 {
                return true;
            }
            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    let (nr, nc) = (nr as usize, nc as usize);
                    if !visited[nr][nc] && grid[nr][nc] == 0 {
                        if fire_time[nr][nc] > t + 1 || (fire_time[nr][nc] == t + 1 && (nr == 0 || nr == rows - 1 || nc == 0 || nc == cols - 1)) {
                            visited[nr][nc] = true;
                            q.push_back((nr, nc));
                        }
                    }
                }
            }
            t += 1;
        }

        false
    }
}
}