impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut current_xor_sum = 0;
        for num in nums {
            current_xor_sum ^= num;
        }

        let diff_xor = current_xor_sum ^ k;

        diff_xor.count_ones() as i32
    }
}