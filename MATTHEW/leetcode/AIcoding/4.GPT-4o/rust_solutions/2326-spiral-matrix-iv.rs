impl Solution {
    pub fn spiral_matrix(m: i32, n: i32, head: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = vec![vec![-1; n as usize]; m as usize];
        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut row = 0;
        let mut col = 0;
        let mut dir = 0;

        for &num in head.iter() {
            if row >= m as usize || col >= n as usize || result[row][col] != -1 {
                return result;
            }
            result[row][col] = num;
            let (dr, dc) = directions[dir];
            let new_row = row as i32 + dr;
            let new_col = col as i32 + dc;
            if new_row < 0 || new_row >= m || new_col < 0 || new_col >= n || result[new_row as usize][new_col as usize] != -1 {
                dir = (dir + 1) % 4;
                let (dr, dc) = directions[dir];
                row = (row as i32 + dr) as usize;
                col = (col as i32 + dc) as usize;
            } else {
                row = new_row as usize;
                col = new_col as usize;
            }
        }
        result
    }
}