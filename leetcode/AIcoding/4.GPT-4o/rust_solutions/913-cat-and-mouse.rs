impl Solution {
    pub fn cat_mouse(game: Vec<Vec<i32>>) -> i32 {
        let n = game.len();
        let mut dp = vec![vec![vec![-1; n]; n]; n * 2];

        fn dfs(cat: usize, mouse: usize, turns: usize, dp: &mut Vec<Vec<Vec<i32>>>, game: &Vec<Vec<i32>>) -> i32 {
            if turns == 2 * game.len() {
                return 0;
            }
            if dp[cat][mouse][turns] != -1 {
                return dp[cat][mouse][turns];
            }
            let next_turn = turns % 2;
            let mut result = if next_turn == 0 { 2 } else { 1 };

            if next_turn == 0 {
                for &next_cat in &game[cat] {
                    if next_cat == mouse {
                        continue;
                    }
                    result = result.min(dfs(next_cat as usize, mouse, turns + 1, dp, game));
                }
            } else {
                for &next_mouse in &game[mouse] {
                    if next_mouse == 0 {
                        return 1;
                    }
                    result = result.min(dfs(cat, next_mouse as usize, turns + 1, dp, game));
                }
            }
            dp[cat][mouse][turns] = result;
            result
        }

        dfs(1, 2, 0, &mut dp, &game)
    }
}