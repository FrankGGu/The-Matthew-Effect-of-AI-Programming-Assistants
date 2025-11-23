impl Solution {
    pub fn get_maximum_xor(nums: Vec<i32>, maximum_bit: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut xor_sum = 0;
        for &num in &nums {
            xor_sum ^= num;
        }

        let max_val = (1 << maximum_bit) - 1;

        for i in (0..nums.len()).rev() {
            result.push(max_val ^ xor_sum);
            xor_sum ^= nums[i];
        }

        result
    }
}