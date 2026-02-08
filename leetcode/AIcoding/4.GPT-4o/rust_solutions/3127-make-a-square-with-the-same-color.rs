pub fn makesquare(matchsticks: Vec<i32>) -> bool {
    let total: i32 = matchsticks.iter().sum();
    if total % 4 != 0 {
        return false;
    }
    let side_length = total / 4;
    let mut sides = vec![0; 4];
    let mut matchsticks = matchsticks;
    matchsticks.sort_unstable_by(|a, b| b.cmp(a));
    fn backtrack(matchsticks: &Vec<i32>, sides: &mut Vec<i32>, index: usize, side_length: i32) -> bool {
        if index == matchsticks.len() {
            return sides.iter().all(|&s| s == side_length);
        }
        for i in 0..4 {
            if sides[i] + matchsticks[index] <= side_length {
                sides[i] += matchsticks[index];
                if backtrack(matchsticks, sides, index + 1, side_length) {
                    return true;
                }
                sides[i] -= matchsticks[index];
            }
            if sides[i] == 0 {
                break;
            }
        }
        false
    }
    backtrack(&matchsticks, &mut sides, 0, side_length)
}