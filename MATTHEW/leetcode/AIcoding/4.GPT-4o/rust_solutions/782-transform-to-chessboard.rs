impl Solution {
    pub fn moves_to_chessboard(board: Vec<Vec<i32>>) -> i32 {
        let n = board.len();
        let row_sum: i32 = board.iter().map(|row| row.iter().sum::<i32>()).sum();
        let col_sum: i32 = (0..n).map(|j| board.iter().map(|row| row[j]).sum::<i32>()).sum();

        if row_sum != n as i32 / 2 && row_sum != (n as i32 + 1) / 2 {
            return -1;
        }
        if col_sum != n as i32 / 2 && col_sum != (n as i32 + 1) / 2 {
            return -1;
        }

        let row_pattern = board[0].to_vec();
        let col_pattern: Vec<i32> = (0..n).map(|i| board[i][0]).collect();

        let row_inversions = Self::count_inversions(&row_pattern, 0);
        let col_inversions = Self::count_inversions(&col_pattern, 0);

        let row_moves = if row_inversions % 2 == 0 { row_inversions / 2 } else { (n as i32 - row_inversions) / 2 };
        let col_moves = if col_inversions % 2 == 0 { col_inversions / 2 } else { (n as i32 - col_inversions) / 2 };

        row_moves + col_moves
    }

    fn count_inversions(pattern: &Vec<i32>, start: i32) -> i32 {
        let n = pattern.len() as i32;
        let mut count = 0;
        for i in 0..n {
            if pattern[i as usize] == start {
                for j in (i + 1)..n {
                    if pattern[j as usize] != start {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}