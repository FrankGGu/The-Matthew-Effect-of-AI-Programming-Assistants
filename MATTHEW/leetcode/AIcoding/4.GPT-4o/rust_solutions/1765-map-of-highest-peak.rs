use std::collections::VecDeque;

pub fn highest_peak(is_water: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let m = is_water.len();
    let n = is_water[0].len();
    let mut result = vec![vec![-1; n]; m];
    let mut queue = VecDeque::new();

    for i in 0..m {
        for j in 0..n {
            if is_water[i][j] == 1 {
                result[i][j] = 0;
                queue.push_back((i, j));
            }
        }
    }

    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

    while let Some((x, y)) = queue.pop_front() {
        for (dx, dy) in &directions {
            let nx = (x as isize + dx) as usize;
            let ny = (y as isize + dy) as usize;

            if nx < m && ny < n && result[nx][ny] == -1 {
                result[nx][ny] = result[x][y] + 1;
                queue.push_back((nx, ny));
            }
        }
    }

    result
}