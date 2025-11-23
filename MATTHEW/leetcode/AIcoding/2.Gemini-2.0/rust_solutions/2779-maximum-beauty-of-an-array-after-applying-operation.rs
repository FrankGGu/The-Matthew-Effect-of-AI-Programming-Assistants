impl Solution {
    pub fn maximum_beauty(nums: Vec<i32>, k: i32) -> i32 {
        let mut sorted_nums = nums.clone();
        sorted_nums.sort();
        let mut left = 0;
        let mut max_len = 0;
        for right in 0..sorted_nums.len() {
            while sorted_nums[right] - sorted_nums[left] > 2 * k {
                left += 1;
            }
            max_len = max_len.max(right - left + 1);
        }
        max_len as i32
    }
}