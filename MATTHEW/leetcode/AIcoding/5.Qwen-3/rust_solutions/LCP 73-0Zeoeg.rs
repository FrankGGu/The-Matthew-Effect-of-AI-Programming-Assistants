impl Solution {

use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn camp_sites(n: i32, m: i32, k: i32, a: Vec<Vec<i32>>) -> i32 {
        let mut queue = VecDeque::new();
        let mut visited = vec![vec![false; m as usize]; n as usize];
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        for i in 0..n as usize {
            for j in 0..m as usize {
                if a[i][j] == 1 {
                    queue.push_back((i, j));
                    visited[i][j] = true;
                }
            }
        }

        let mut steps = 0;
        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let (x, y) = queue.pop_front().unwrap();
                for &(dx, dy) in &directions {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;
                    if nx >= 0 && ny >= 0 && nx < n && ny < m && !visited[nx as usize][ny as usize] && a[nx as usize][ny as usize] == 0 {
                        visited[nx as usize][ny as usize] = true;
                        queue.push_back((nx as usize, ny as usize));
                    }
                }
            }
            if !queue.is_empty() {
                steps += 1;
            }
        }

        steps
    }
}
}