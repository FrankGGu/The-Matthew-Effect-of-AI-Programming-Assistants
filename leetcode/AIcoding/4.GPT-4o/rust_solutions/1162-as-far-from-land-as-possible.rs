impl Solution {
    pub fn max_distance(grid: Vec<Vec<i32>>) -> i32 {
        let mut queue = VecDeque::new();
        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];
        let mut max_distance = -1;

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 {
                    queue.push_back((i, j));
                }
            }
        }

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let (x, y) = queue.pop_front().unwrap();
                for direction in &directions {
                    let new_x = x as isize + direction.0;
                    let new_y = y as isize + direction.1;
                    if new_x >= 0 && new_x < grid.len() as isize && new_y >= 0 && new_y < grid[0].len() as isize && grid[new_x as usize][new_y as usize] == 0 {
                        grid[new_x as usize][new_y as usize] = 1;
                        queue.push_back((new_x as usize, new_y as usize));
                    }
                }
            }
            max_distance += 1;
        }

        if max_distance == 0 { -1 } else { max_distance }
    }
}