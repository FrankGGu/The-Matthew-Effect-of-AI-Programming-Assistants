impl Solution {
    pub fn paths_with_max_score(board: Vec<String>) -> Vec<i32> {
        let m = board.len();
        let n = board[0].len();
        let board_chars: Vec<Vec<char>> = board.iter().map(|s| s.chars().collect()).collect();

        // dp[i][j] stores (max_score_to_reach_i_j, num_paths_for_max_score)
        // Initialize with (i32::MIN, 0) to represent unreachable states.
        let mut dp: Vec<Vec<(i32, i32)>> = vec![vec![(i32::MIN, 0); n]; m];

        let modulo = 1_000_000_007;

        // Base case: 'E' at (0, 0)
        // Score at 'E' is 0, and there's 1 way to be at 'E'.
        dp[0][0] = (0, 1);

        for i in 0..m {
            for j in 0..n {
                // If current cell is an obstacle or the start 'E' (already handled)
                if board_chars[i][j] == 'X' || (i == 0 && j == 0) {
                    continue;
                }

                let current_val = if board_chars[i][j] == 'S' {
                    0 // 'S' value is 0, and its score is not added to the path sum (as per example interpretation)
                } else {
                    board_chars[i][j].to_digit(10).unwrap() as i32
                };

                let mut max_s = i32::MIN;
                let mut num_p = 0;

                // Check paths from up (i-1, j)
                if i > 0 {
                    let (prev_s, prev_p) = dp[i - 1][j];
                    if prev_p > 0 { // If reachable
                        if prev_s > max_s {
                            max_s = prev_s;
                            num_p = prev_p;
                        } else if prev_s == max_s {
                            num_p = (num_p + prev_p) % modulo;
                        }
                    }
                }

                // Check paths from left (i, j-1)
                if j > 0 {
                    let (prev_s, prev_p) = dp[i][j - 1];
                    if prev_p > 0 { // If reachable
                        if prev_s > max_s {
                            max_s = prev_s;
                            num_p = prev_p;
                        } else if prev_s == max_s {
                            num_p = (num_p + prev_p) % modulo;
                        }
                    }
                }

                // Check paths from up-left (i-1, j-1)
                if i > 0 && j > 0 {
                    let (prev_s, prev_p) = dp[i - 1][j - 1];
                    if prev_p > 0 { // If reachable
                        if prev_s > max_s {
                            max_s = prev_s;
                            num_p = prev_p;
                        } else if prev_s == max_s {
                            num_p = (num_p + prev_p) % modulo;
                        }
                    }
                }

                // If any path was found to previous cells
                if num_p > 0 {
                    dp[i][j] = (max_s + current_val, num_p);
                }
                // Else, dp[i][j] remains (i32::MIN, 0), meaning unreachable.
            }
        }

        let (final_score, final_paths) = dp[m - 1][n - 1];

        if final_paths == 0 {
            vec![0, 0]
        } else {
            vec![final_score, final_paths]
        }
    }
}