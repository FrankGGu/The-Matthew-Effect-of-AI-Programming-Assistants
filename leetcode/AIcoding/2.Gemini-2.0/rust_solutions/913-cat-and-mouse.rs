impl Solution {
    pub fn cat_mouse(graph: Vec<Vec<i32>>) -> i32 {
        let n = graph.len();
        let mut dp = vec![vec![vec![0; 2 * n]; n]; n];

        fn get_result(
            mouse: usize,
            cat: usize,
            turn: usize,
            graph: &Vec<Vec<i32>>,
            dp: &mut Vec<Vec<Vec<i32>>>,
        ) -> i32 {
            if turn == 2 * graph.len() {
                return 0;
            }

            if dp[mouse][cat][turn] != 0 {
                return dp[mouse][cat][turn];
            }

            if mouse == cat {
                dp[mouse][cat][turn] = 2;
                return 2;
            }

            if mouse == 0 {
                dp[mouse][cat][turn] = 1;
                return 1;
            }

            let is_mouse_turn = turn % 2 == 0;

            if is_mouse_turn {
                let mut can_win = false;
                let mut all_lose = true;

                for &next_mouse in &graph[mouse] {
                    let next_mouse = next_mouse as usize;
                    let result = get_result(next_mouse, cat, turn + 1, graph, dp);
                    if result == 1 {
                        can_win = true;
                        all_lose = false;
                        break;
                    } else if result == 0 {
                        all_lose = false;
                    }
                }

                if can_win {
                    dp[mouse][cat][turn] = 1;
                    return 1;
                } else if all_lose {
                    dp[mouse][cat][turn] = 2;
                    return 2;
                } else {
                    dp[mouse][cat][turn] = 0;
                    return 0;
                }
            } else {
                let mut can_lose = false;
                let mut all_win = true;

                for &next_cat in &graph[cat] {
                    let next_cat = next_cat as usize;
                    if next_cat != 0 {
                        let result = get_result(mouse, next_cat, turn + 1, graph, dp);
                        if result == 2 {
                            can_lose = true;
                            all_win = false;
                            break;
                        } else if result == 0 {
                            all_win = false;
                        }
                    }
                }

                if can_lose {
                    dp[mouse][cat][turn] = 2;
                    return 2;
                } else if all_win {
                    dp[mouse][cat][turn] = 1;
                    return 1;
                } else {
                    dp[mouse][cat][turn] = 0;
                    return 0;
                }
            }
        }

        get_result(1, 2, 0, &graph, &mut dp)
    }
}