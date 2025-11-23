impl Solution {
    pub fn get_maximum_xor(nums: Vec<i32>, maximum_bit: i32) -> Vec<i32> {
        let n = nums.len();
        let mask = (1 << maximum_bit) - 1;

        let mut current_xor_sum = 0;
        for &num in nums.iter() {
            current_xor_sum ^= num;
        }

        let mut result = Vec::with_capacity(n);

        for i in (0..n).rev() {
            let k = current_xor_sum ^ mask;
            result.push(k);
            current_xor_sum ^= nums[i];
        }

        result
    }
}