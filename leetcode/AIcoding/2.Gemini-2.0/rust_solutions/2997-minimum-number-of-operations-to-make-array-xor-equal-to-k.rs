impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut xor_sum = 0;
        for &num in &nums {
            xor_sum ^= num;
        }

        if xor_sum == k {
            return 0;
        } else {
            return 1;
        }
    }
}