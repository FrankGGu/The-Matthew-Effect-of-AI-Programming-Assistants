impl Solution {
    pub fn does_valid_array_exist(derived: Vec<i32>) -> bool {
        let mut xor_sum = 0;
        for &val in &derived {
            xor_sum ^= val;
        }
        xor_sum == 0
    }
}