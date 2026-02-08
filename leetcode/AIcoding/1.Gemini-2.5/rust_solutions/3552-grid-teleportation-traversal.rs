use std::collections::{VecDeque, HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn grid_teleportation_traversal(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return -1;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return -1;
        }

        let target_r = rows - 1;
        let target_c = cols - 1;

        if rows == 1 && cols == 1 {
            return 0;
        }

        let mut teleport_groups: HashMap<i32, Vec<(usize, usize)>> = HashMap::new();
        for r in 0..rows {
            for c in 0..cols {
                teleport_groups.entry(grid[r][c]).or_insert_with(Vec::new).push((r, c));
            }
        }

        let mut queue: VecDeque<(usize, usize, i32)> = VecDeque::new();
        let mut visited: Vec<Vec<bool>> = vec![vec![false; cols]; rows];
        let mut teleported_from_value: HashSet<i32> = HashSet::new();

        queue.push_back((0, 0, 0));
        visited[0][0] = true;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c, steps)) = queue.pop_front() {
            if r == target_r && c == target_c {
                return steps;
            }

            for i in 0..4 {
                let nr = r as isize + dr[i];
                let nc = c as isize + dc[i];

                if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    if !visited[nr][nc] {
                        visited[nr][nc] = true;
                        queue.push_back((nr, nc, steps + 1));
                    }
                }
            }

            let current_val = grid[r][c];
            if !teleported_from_value.contains(&current_val) {
                teleported_from_value.insert(current_val);

                if let Some(group) = teleport_groups.get(&current_val) {
                    for &(tr, tc) in group {
                        if !visited[tr][tc] {
                            visited[tr][tc] = true;
                            queue.push_back((tr, tc, steps + 1));
                        }
                    }
                }
            }
        }

        -1
    }
}