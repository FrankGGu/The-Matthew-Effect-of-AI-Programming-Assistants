impl Solution {
    pub fn makesquare(matchsticks: Vec<i32>) -> bool {
        let total: i32 = matchsticks.iter().sum();
        if total % 4 != 0 {
            return false;
        }
        let side = total / 4;
        let mut matchsticks = matchsticks;
        matchsticks.sort_by(|a, b| b.cmp(a));
        let mut sides = vec![0; 4];

        fn backtrack(index: usize, matchsticks: &Vec<i32>, sides: &mut Vec<i32>, side: i32) -> bool {
            if index == matchsticks.len() {
                return sides.iter().all(|&s| s == side);
            }
            for i in 0..4 {
                if sides[i] + matchsticks[index] <= side {
                    sides[i] += matchsticks[index];
                    if backtrack(index + 1, matchsticks, sides, side) {
                        return true;
                    }
                    sides[i] -= matchsticks[index];
                }
            }
            false
        }

        backtrack(0, &matchsticks, &mut sides, side)
    }
}