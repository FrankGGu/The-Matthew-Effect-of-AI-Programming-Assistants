impl Solution {
    pub fn broken_calc(start_value: i32, target: i32) -> i32 {
        let mut operations = 0;
        let mut target = target;
        while target > start_value {
            operations += 1;
            if target % 2 == 1 {
                target += 1;
            } else {
                target /= 2;
            }
        }
        operations + start_value - target
    }
}