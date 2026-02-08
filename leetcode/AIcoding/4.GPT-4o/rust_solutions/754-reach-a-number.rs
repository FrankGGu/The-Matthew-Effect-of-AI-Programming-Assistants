impl Solution {
    pub fn reach_number(target: i32) -> i32 {
        let target = target.abs();
        let mut sum = 0;
        let mut steps = 0;

        while sum < target || (sum - target) % 2 != 0 {
            steps += 1;
            sum += steps;
        }

        steps
    }
}