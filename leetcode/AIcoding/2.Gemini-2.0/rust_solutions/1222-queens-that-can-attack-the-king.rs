impl Solution {
    pub fn queens_attackthe_king(queens: Vec<Vec<i32>>, king: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut board = [[false; 8]; 8];
        for queen in &queens {
            board[queen[0] as usize][queen[1] as usize] = true;
        }

        let directions = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),         (0, 1),
            (1, -1), (1, 0), (1, 1),
        ];

        for &(dx, dy) in &directions {
            let mut x = king[0];
            let mut y = king[1];

            while x >= 0 && x < 8 && y >= 0 && y < 8 {
                x += dx;
                y += dy;

                if x >= 0 && x < 8 && y >= 0 && y < 8 && board[x as usize][y as usize] {
                    result.push(vec![x, y]);
                    break;
                }
            }
        }

        result
    }
}