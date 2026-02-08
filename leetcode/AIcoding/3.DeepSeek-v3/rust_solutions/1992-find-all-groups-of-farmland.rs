impl Solution {
    pub fn find_farmland(land: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let rows = land.len();
        if rows == 0 {
            return result;
        }
        let cols = land[0].len();
        let mut visited = vec![vec![false; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                if land[i][j] == 1 && !visited[i][j] {
                    let mut r1 = i;
                    let mut c1 = j;
                    let mut r2 = i;
                    let mut c2 = j;
                    let mut stack = vec![(i, j)];
                    visited[i][j] = true;

                    while let Some((x, y)) = stack.pop() {
                        if x > r2 || (x == r2 && y > c2) {
                            r2 = x;
                            c2 = y;
                        }
                        for (dx, dy) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                            let nx = x as i32 + dx;
                            let ny = y as i32 + dy;
                            if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                                let nx = nx as usize;
                                let ny = ny as usize;
                                if land[nx][ny] == 1 && !visited[nx][ny] {
                                    visited[nx][ny] = true;
                                    stack.push((nx, ny));
                                }
                            }
                        }
                    }
                    result.push(vec![r1 as i32, c1 as i32, r2 as i32, c2 as i32]);
                }
            }
        }
        result
    }
}