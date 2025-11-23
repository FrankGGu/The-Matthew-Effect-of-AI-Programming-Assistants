struct Solution;

impl Solution {
    fn char_to_coords(char_idx: u8) -> (i32, i32) {
        (char_idx as i32 / 6, char_idx as i32 % 6)
    }

    fn manhattan_distance(idx1: u8, idx2: u8) -> i32 {
        if idx1 == 26 {
            return 0;
        }
        let (r1, c1) = Self::char_to_coords(idx1);
        let (r2, c2) = Self::char_to_coords(idx2);
        (r1 - r2).abs() + (c1 - c2).abs()
    }

    pub fn minimum_distance(word: String) -> i32 {
        let n = word.len();
        let mut prev_dp = vec![vec![i32::MAX; 27]; 27];
        let mut curr_dp = vec![vec![i32::MAX; 27]; 27];

        prev_dp[26][26] = 0;

        for i in 0..n {
            let target_char_idx = (word.as_bytes()[i] - b'A') as u8;

            for r in 0..27 {
                for c in 0..27 {
                    curr_dp[r][c] = i32::MAX;
                }
            }

            for prev_f1 in 0..27 {
                for prev_f2 in 0..27 {
                    if prev_dp[prev_f1 as usize][prev_f2 as usize] == i32::MAX {
                        continue;
                    }

                    let current_dist = prev_dp[prev_f1 as usize][prev_f2 as usize];

                    let cost_move_f1 = Self::manhattan_distance(prev_f1, target_char_idx);
                    let new_dist_f1 = current_dist + cost_move_f1;
                    curr_dp[target_char_idx as usize][prev_f2 as usize] =
                        curr_dp[target_char_idx as usize][prev_f2 as usize]
                            .min(new_dist_f1);

                    let cost_move_f2 = Self::manhattan_distance(prev_f2, target_char_idx);
                    let new_dist_f2 = current_dist + cost_move_f2;
                    curr_dp[prev_f1 as usize][target_char_idx as usize] =
                        curr_dp[prev_f1 as usize][target_char_idx as usize]
                            .min(new_dist_f2);
                }
            }
            std::mem::swap(&mut prev_dp, &mut curr_dp);
        }

        let mut min_total_dist = i32::MAX;
        for f1 in 0..27 {
            for f2 in 0..27 {
                min_total_dist = min_total_dist.min(prev_dp[f1 as usize][f2 as usize]);
            }
        }

        min_total_dist
    }
}