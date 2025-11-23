impl Solution {
    pub fn tictactoe(moves: Vec<Vec<i32>>) -> String {
        let mut grid = vec![vec![' '; 3]; 3];
        for (i, mv) in moves.iter().enumerate() {
            let (x, y) = (mv[0] as usize, mv[1] as usize);
            grid[x][y] = if i % 2 == 0 { 'A' } else { 'B' };
        }

        fn check_winner(grid: &Vec<Vec<char>>, player: char) -> bool {
            for i in 0..3 {
                if grid[i][0] == player && grid[i][1] == player && grid[i][2] == player {
                    return true;
                }
                if grid[0][i] == player && grid[1][i] == player && grid[2][i] == player {
                    return true;
                }
            }
            if grid[0][0] == player && grid[1][1] == player && grid[2][2] == player {
                return true;
            }
            if grid[0][2] == player && grid[1][1] == player && grid[2][0] == player {
                return true;
            }
            false
        }

        if check_winner(&grid, 'A') {
            return "A".to_string();
        }
        if check_winner(&grid, 'B') {
            return "B".to_string();
        }
        if moves.len() == 9 {
            "Draw".to_string()
        } else {
            "Pending".to_string()
        }
    }
}