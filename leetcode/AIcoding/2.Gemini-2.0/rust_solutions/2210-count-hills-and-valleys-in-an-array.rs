impl Solution {
    pub fn count_hills_and_valleys(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut prev = nums[0];
        let mut i = 1;
        while i < nums.len() - 1 {
            if nums[i] > prev && nums[i] > nums[i + 1] {
                count += 1;
                prev = nums[i];
            } else if nums[i] < prev && nums[i] < nums[i + 1] {
                count += 1;
                prev = nums[i];
            } else if nums[i] != prev {
                prev = nums[i];
            }
            i += 1;
        }
        count
    }
}