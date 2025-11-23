impl Solution {
    pub fn min_operations_to_make_xor_equal(nums: Vec<i32>, k: i32) -> i32 {
        let mut current_xor_sum = 0;
        for num in nums {
            current_xor_sum ^= num;
        }
        (current_xor_sum ^ k).count_ones() as i32
    }
}