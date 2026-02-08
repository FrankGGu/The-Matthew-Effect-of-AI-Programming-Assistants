impl Solution {
    pub fn makesquare(matchsticks: Vec<i32>) -> bool {
        let sum: i32 = matchsticks.iter().sum();
        if sum % 4 != 0 || matchsticks.len() < 4 {
            return false;
        }
        let side = sum / 4;
        let mut sides = vec![0; 4];
        let mut matchsticks = matchsticks;
        matchsticks.sort_unstable_by(|a, b| b.cmp(a));
        Self::can_form_square(&matchsticks, &mut sides, 0, side)
    }

    fn can_form_square(matchsticks: &[i32], sides: &mut Vec<i32>, index: usize, side: i32) -> bool {
        if index == matchsticks.len() {
            return sides.iter().all(|&s| s == side);
        }
        for i in 0..4 {
            if sides[i] + matchsticks[index] <= side {
                sides[i] += matchsticks[index];
                if Self::can_form_square(matchsticks, sides, index + 1, side) {
                    return true;
                }
                sides[i] -= matchsticks[index];
            }
        }
        false
    }
}