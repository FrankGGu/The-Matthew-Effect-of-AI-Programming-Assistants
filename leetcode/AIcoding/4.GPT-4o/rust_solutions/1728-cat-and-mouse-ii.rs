impl Solution {
    pub fn cat_mouse_game(graph: Vec<Vec<i32>>) -> i32 {
        let n = graph.len();
        let mut dp = vec![vec![vec![-1; 2 * n]; n]; n];

        fn dfs(cat: usize, mouse: usize, turn: usize, dp: &mut Vec<Vec<Vec<i32>>>, graph: &Vec<Vec<i32>>) -> i32 {
            if dp[cat][mouse][turn] != -1 {
                return dp[cat][mouse][turn];
            }
            if mouse == 0 {
                return dp[cat][mouse][turn] = 1;
            }
            if cat == mouse {
                return dp[cat][mouse][turn] = 2;
            }
            let next_turn = 1 - turn;
            if turn == 0 {
                let mut can_win = false;
                for &next_cat in &graph[cat] {
                    if dfs(next_cat as usize, mouse, next_turn, dp, graph) == 2 {
                        can_win = true;
                    }
                }
                dp[cat][mouse][turn] = if can_win { 1 } else { 2 };
            } else {
                let mut can_lose = true;
                for &next_mouse in &graph[mouse] {
                    if next_mouse > 0 && dfs(cat, next_mouse as usize, next_turn, dp, graph) == 1 {
                        can_lose = false;
                    }
                }
                dp[cat][mouse][turn] = if can_lose { 2 } else { 1 };
            }
            dp[cat][mouse][turn]
        }

        dfs(1, 2, 0, &mut dp, &graph)
    }
}