impl Solution {
    pub fn reach_number(target: i32) -> i32 {
        let target = target.abs();
        let mut sum = 0;
        let mut steps = 0;
        while sum < target {
            steps += 1;
            sum += steps;
        }
        if sum == target {
            return steps;
        }
        let diff = sum - target;
        if diff % 2 == 0 {
            return steps;
        } else {
            return steps + if steps % 2 == 0 { 1 } else { 2 };
        }
    }
}