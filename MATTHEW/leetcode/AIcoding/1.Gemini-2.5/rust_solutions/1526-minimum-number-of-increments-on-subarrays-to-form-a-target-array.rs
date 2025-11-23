impl Solution {
    pub fn min_number_operations(target: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut prev_val = 0;

        for &val in target.iter() {
            if val > prev_val {
                operations += val - prev_val;
            }
            prev_val = val;
        }

        operations
    }
}