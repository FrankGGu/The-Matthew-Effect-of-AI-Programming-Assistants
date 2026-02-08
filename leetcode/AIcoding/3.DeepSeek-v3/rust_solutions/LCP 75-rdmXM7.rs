use std::collections::VecDeque;

impl Solution {
    pub fn teleportation_spell(spell: Vec<Vec<i32>>) -> i32 {
        let n = spell.len();
        let m = spell[0].len();
        let mut visited = vec![vec![false; m]; n];
        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 0));
        visited[0][0] = true;

        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((x, y, steps)) = queue.pop_front() {
            if x == n as i32 - 1 && y == m as i32 - 1 {
                return steps;
            }

            for &(dx, dy) in &dirs {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && nx < n as i32 && ny >= 0 && ny < m as i32 && !visited[nx as usize][ny as usize] {
                    visited[nx as usize][ny as usize] = true;
                    queue.push_back((nx, ny, steps + 1));
                }
            }

            let tele_x = spell[x as usize][y as usize] / m as i32;
            let tele_y = spell[x as usize][y as usize] % m as i32;
            if tele_x >= 0 && tele_x < n as i32 && tele_y >= 0 && tele_y < m as i32 && !visited[tele_x as usize][tele_y as usize] {
                visited[tele_x as usize][tele_y as usize] = true;
                queue.push_back((tele_x, tele_y, steps + 1));
            }
        }

        -1
    }
}