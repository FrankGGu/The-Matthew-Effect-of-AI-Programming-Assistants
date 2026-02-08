impl Solution {
    pub fn broken_calculator(start_value: i32, target: i32) -> i32 {
        let mut operations = 0;
        let mut current = target;

        while current > start_value {
            if current % 2 == 0 {
                current /= 2;
            } else {
                current += 1;
            }
            operations += 1;
        }

        operations + (start_value - current)
    }
}