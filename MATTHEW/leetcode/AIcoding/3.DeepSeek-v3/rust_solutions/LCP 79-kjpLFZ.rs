use std::collections::HashSet;

impl Solution {
    pub fn extract_mantra(matrix: Vec<String>, mantra: String) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mantra_chars: Vec<char> = mantra.chars().collect();
        let k = mantra_chars.len();

        let mut visited = HashSet::new();
        let mut queue = std::collections::VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if matrix[i].chars().nth(j).unwrap() == mantra_chars[0] {
                    queue.push_back((i, j, 0));
                    visited.insert((i, j, 0));
                }
            }
        }

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut steps = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let (x, y, pos) = queue.pop_front().unwrap();
                if pos == k - 1 {
                    return steps + 1;
                }
                for (dx, dy) in dirs.iter() {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;
                    if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                        let nx = nx as usize;
                        let ny = ny as usize;
                        if matrix[nx].chars().nth(ny).unwrap() == mantra_chars[pos + 1] {
                            if !visited.contains(&(nx, ny, pos + 1)) {
                                visited.insert((nx, ny, pos + 1));
                                queue.push_back((nx, ny, pos + 1));
                            }
                        } else {
                            if !visited.contains(&(nx, ny, pos)) {
                                visited.insert((nx, ny, pos));
                                queue.push_back((nx, ny, pos));
                            }
                        }
                    }
                }
            }
            steps += 1;
        }

        -1
    }
}