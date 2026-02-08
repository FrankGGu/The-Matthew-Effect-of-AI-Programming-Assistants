impl Solution {
    pub fn queens_attackthe_king(queens: Vec<Vec<i32>>, king: Vec<i32>) -> Vec<Vec<i32>> {
        let mut board = [[false; 8]; 8];
        for queen in queens {
            board[queen[0] as usize][queen[1] as usize] = true;
        }
        let king_x = king[0] as usize;
        let king_y = king[1] as usize;
        let mut result = Vec::new();

        for dx in -1..=1 {
            for dy in -1..=1 {
                if dx == 0 && dy == 0 {
                    continue;
                }
                let mut x = king_x as i32;
                let mut y = king_y as i32;
                loop {
                    x += dx;
                    y += dy;
                    if x < 0 || x >= 8 || y < 0 || y >= 8 {
                        break;
                    }
                    if board[x as usize][y as usize] {
                        result.push(vec![x, y]);
                        break;
                    }
                }
            }
        }
        result
    }
}