impl Solution {
    pub fn update_board(board: Vec<Vec<char>>, click: Vec<i32>) -> Vec<Vec<char>> {
        let (x, y) = (click[0] as usize, click[1] as usize);
        let mut board = board;

        if board[x][y] == 'M' {
            board[x][y] = 'X';
            return board;
        }

        let directions = vec![(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
        let mut visited = vec![vec![false; board[0].len()]; board.len()];
        let mut queue = vec![(x, y)];

        while let Some((i, j)) = queue.pop() {
            if visited[i][j] {
                continue;
            }
            visited[i][j] = true;

            let mut mines = 0;

            for (dx, dy) in &directions {
                let ni = (i as isize + dx) as usize;
                let nj = (j as isize + dy) as usize;
                if ni < board.len() && nj < board[0].len() {
                    if board[ni][nj] == 'M' {
                        mines += 1;
                    }
                }
            }

            if mines > 0 {
                board[i][j] = char::from_digit(mines as u32, 10).unwrap();
            } else {
                board[i][j] = 'B';
                for (dx, dy) in &directions {
                    let ni = (i as isize + dx) as usize;
                    let nj = (j as isize + dy) as usize;
                    if ni < board.len() && nj < board[0].len() && !visited[ni][nj] && board[ni][nj] == 'E' {
                        queue.push((ni, nj));
                    }
                }
            }
        }

        board
    }
}