use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn cat_mouse_game(graph: Vec<Vec<i32>>) -> i32 {
        let n = graph.len();
        // memo[mouse_pos][cat_pos][turn]
        // turn: 0 for mouse, 1 for cat
        // value: 0 (Draw), 1 (Mouse wins), 2 (Cat wins), -1 (Unvisited)
        // During DFS, a state temporarily marked with 0 means it's currently being visited
        // in the recursion stack, indicating a cycle if revisited.
        let mut memo: Vec<Vec<Vec<i32>>> = vec![vec![vec![-1; 2]; n]; n];

        Self::dfs(1, 2, 0, &graph, &mut memo)
    }

    // Returns: 0 (Draw), 1 (Mouse wins), 2 (Cat wins)
    fn dfs(mouse: usize, cat: usize, turn: usize, graph: &Vec<Vec<i32>>, memo: &mut Vec<Vec<Vec<i32>>>) -> i32 {
        // Base cases for immediate win/loss
        if mouse == 0 {
            return 1; // Mouse wins if it reaches hole 0
        }
        if cat == mouse {
            return 2; // Cat wins if it catches the mouse
        }

        // Memoization check
        if memo[mouse][cat][turn] != -1 {
            // If this state has been computed, return its value.
            // If it's 0, it means it was marked as "visiting" earlier in the current
            // recursion path, indicating a cycle. In this game, a cycle implies a draw.
            return memo[mouse][cat][turn];
        }

        // Mark current state as visiting (temporarily as 0, which is also the draw outcome)
        memo[mouse][cat][turn] = 0;

        let result;
        if turn == 0 { // Mouse's turn
            let mut mouse_can_win_this_turn = false;
            let mut mouse_can_draw_this_turn = false;

            for &next_mouse_pos_i32 in graph[mouse].iter() {
                let next_mouse_pos = next_mouse_pos_i32 as usize;
                let res = Self::dfs(next_mouse_pos, cat, 1, graph, memo); // Next is Cat's turn
                if res == 1 { // Mouse wins
                    mouse_can_win_this_turn = true;
                    break; // Mouse found a winning move, no need to check further
                }
                if res == 0 { // Draw
                    mouse_can_draw_this_turn = true;
                }
            }

            if mouse_can_win_this_turn {
                result = 1; // Mouse can force a win
            } else if mouse_can_draw_this_turn {
                result = 0; // Mouse cannot win, but can force a draw
            } else {
                result = 2; // All moves lead to Cat winning
            }
        } else { // Cat's turn
            let mut cat_can_win_this_turn = false;
            let mut cat_can_draw_this_turn = false;

            for &next_cat_pos_i32 in graph[cat].iter() {
                let next_cat_pos = next_cat_pos_i32 as usize;
                if next_cat_pos == 0 {
                    continue; // Cat cannot move to hole 0
                }
                let res = Self::dfs(mouse, next_cat_pos, 0, graph, memo); // Next is Mouse's turn
                if res == 2 { // Cat wins
                    cat_can_win_this_turn = true;
                    break; // Cat found a winning move, no need to check further
                }
                if res == 0 { // Draw
                    cat_can_draw_this_turn = true;
                }
            }

            if cat_can_win_this_turn {
                result = 2; // Cat can force a win
            } else if cat_can_draw_this_turn {
                result = 0; // Cat cannot win, but can force a draw
            } else {
                result = 1; // All moves lead to Mouse winning
            }
        }

        // Store the computed result and return it
        memo[mouse][cat][turn] = result;
        result
    }
}