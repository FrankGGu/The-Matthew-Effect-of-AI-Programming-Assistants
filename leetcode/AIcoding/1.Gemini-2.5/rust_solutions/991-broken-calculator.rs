impl Solution {
    pub fn broken_calc(start_value: i32, target: i32) -> i32 {
        let mut ops = 0;
        let mut current_target = target;

        while current_target > start_value {
            if current_target % 2 == 0 {
                current_target /= 2;
            } else {
                current_target += 1;
            }
            ops += 1;
        }

        ops + (start_value - current_target)
    }
}