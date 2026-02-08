use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn escape_fire(fire: Vec<Vec<char>>, src: Vec<i32>, dst: Vec<i32>) -> i32 {
        let rows = fire.len();
        let cols = fire[0].len();
        let mut visited = HashSet::new();
        let mut fire_time = vec![vec![i32::MAX; cols]; rows];
        let mut queue = VecDeque::new();

        for (r, row) in fire.iter().enumerate() {
            for (c, &cell) in row.iter().enumerate() {
                if cell == 'F' {
                    fire_time[r][c] = 0;
                    queue.push_back((r, c));
                }
            }
        }

        while let Some((r, c)) = queue.pop_front() {
            for (dr, dc) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                let nr = (r as i32 + dr) as usize;
                let nc = (c as i32 + dc) as usize;
                if nr < rows && nc < cols && fire_time[nr][nc] > fire_time[r][c] + 1 {
                    fire_time[nr][nc] = fire_time[r][c] + 1;
                    queue.push_back((nr, nc));
                }
            }
        }

        let (start_r, start_c) = (src[0] as usize, src[1] as usize);
        let (end_r, end_c) = (dst[0] as usize, dst[1] as usize);
        visited.insert((start_r, start_c));
        queue.push_back((start_r, start_c));
        let mut steps = 0;

        while !queue.is_empty() {
            steps += 1;
            let size = queue.len();
            for _ in 0..size {
                let (r, c) = queue.pop_front().unwrap();
                if (r, c) == (end_r, end_c) {
                    return steps;
                }
                for (dr, dc) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                    let nr = (r as i32 + dr) as usize;
                    let nc = (c as i32 + dc) as usize;
                    if nr < rows && nc < cols && !visited.contains(&(nr, nc)) && fire_time[nr][nc] > steps {
                        visited.insert((nr, nc));
                        queue.push_back((nr, nc));
                    }
                }
            }
        }

        -1
    }
}