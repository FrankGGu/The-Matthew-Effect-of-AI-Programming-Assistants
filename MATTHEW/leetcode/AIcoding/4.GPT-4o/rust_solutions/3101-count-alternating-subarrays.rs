impl Solution {
    pub fn count_alternating_subarrays(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = nums.len();

        for i in 0..n {
            if i > 0 && nums[i] == nums[i - 1] {
                continue;
            }
            let mut length = 1;
            while i + length < n && nums[i + length] != nums[i + length - 1] {
                length += 1;
            }
            count += (length - 1) * length / 2;
        }

        count
    }
}