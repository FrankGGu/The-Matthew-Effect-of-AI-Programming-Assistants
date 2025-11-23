impl Solution {
    pub fn makesquare(matchsticks: Vec<i32>) -> bool {
        let n = matchsticks.len();
        if n < 4 {
            return false;
        }

        let total_sum: i64 = matchsticks.iter().map(|&x| x as i64).sum();
        if total_sum % 4 != 0 {
            return false;
        }

        let target_side = total_sum / 4;

        for &stick in &matchsticks {
            if (stick as i64) > target_side {
                return false;
            }
        }

        let mut matchsticks_i64: Vec<i64> = matchsticks.into_iter().map(|x| x as i64).collect();
        matchsticks_i64.sort_unstable_by(|a, b| b.cmp(a));

        let mut sides = [0_i64; 4];

        Self::backtrack(0, &mut sides, &matchsticks_i64, target_side)
    }

    fn backtrack(
        index: usize,
        sides: &mut [i64; 4],
        matchsticks: &[i64],
        target_side: i64,
    ) -> bool {
        if index == matchsticks.len() {
            return true;
        }

        let current_stick = matchsticks[index];

        for i in 0..4 {
            if sides[i] + current_stick <= target_side {
                sides[i] += current_stick;
                if Self::backtrack(index + 1, sides, matchsticks, target_side) {
                    return true;
                }
                sides[i] -= current_stick;
            }

            // Optimization for identical bins:
            // If we tried to place the current stick into sides[i] (either it didn't fit,
            // or it fit but didn't lead to a solution), AND sides[i] is currently empty (0),
            // then trying to place it into any other empty side (sides[j] == 0) will lead
            // to the exact same subproblem. So we can break and stop trying other empty sides.
            if sides[i] == 0 {
                break;
            }
        }
        false
    }
}