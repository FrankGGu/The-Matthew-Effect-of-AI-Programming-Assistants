impl Solution {
    pub fn find_winning_player(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut winning_players_count = 0;

        for i in 0..n {
            let mut is_winning = true;
            for j in 0..n {
                if i == j {
                    continue;
                }
                if grid[i][j] == 0 {
                    is_winning = false;
                    break;
                }
            }
            if is_winning {
                winning_players_count += 1;
            }
        }

        winning_players_count
    }
}