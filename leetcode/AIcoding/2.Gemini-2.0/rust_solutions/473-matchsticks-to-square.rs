impl Solution {
    pub fn makesquare(matchsticks: Vec<i32>) -> bool {
        let sum: i32 = matchsticks.iter().sum();
        if sum % 4 != 0 {
            return false;
        }
        let side = sum / 4;
        let n = matchsticks.len();
        let mut matchsticks = matchsticks;
        matchsticks.sort_by(|a, b| b.cmp(a));

        fn backtrack(index: usize, sides: &mut [i32; 4], matchsticks: &Vec<i32>, side: i32) -> bool {
            if index == matchsticks.len() {
                return sides.iter().all(|&s| s == side);
            }

            for i in 0..4 {
                if sides[i] + matchsticks[index] <= side {
                    sides[i] += matchsticks[index];
                    if backtrack(index + 1, sides, matchsticks, side) {
                        return true;
                    }
                    sides[i] -= matchsticks[index];
                }
            }

            false
        }

        let mut sides = [0; 4];
        backtrack(0, &mut sides, &matchsticks, side)
    }
}