impl Solution {
    pub fn game_of_life(board: &mut Vec<Vec<i32>>) {
        let m = board.len();
        let n = board[0].len();

        let mut next_board = board.clone();

        for i in 0..m {
            for j in 0..n {
                let mut live_neighbors = 0;

                for x in i.max(1) - 1..=(i + 1).min(m - 1) {
                    for y in j.max(1) - 1..=(j + 1).min(n - 1) {
                        if x == i && y == j {
                            continue;
                        }
                        live_neighbors += board[x][y];
                    }
                }

                if board[i][j] == 1 {
                    if live_neighbors < 2 || live_neighbors > 3 {
                        next_board[i][j] = 0;
                    }
                } else {
                    if live_neighbors == 3 {
                        next_board[i][j] = 1;
                    }
                }
            }
        }

        *board = next_board;
    }
}