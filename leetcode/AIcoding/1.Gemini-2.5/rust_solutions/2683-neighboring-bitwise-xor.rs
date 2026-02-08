impl Solution {
    pub fn does_valid_array_exist(derived: Vec<i32>) -> bool {
        let mut xor_sum = 0;
        for &num in derived.iter() {
            xor_sum ^= num;
        }
        xor_sum == 0
    }
}