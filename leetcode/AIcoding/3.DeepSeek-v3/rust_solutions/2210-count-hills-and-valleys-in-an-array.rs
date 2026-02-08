impl Solution {
    pub fn count_hill_valley(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut prev = nums[0];
        let mut i = 1;
        while i < nums.len() - 1 {
            let left = prev;
            let mut right = nums[i + 1];
            if nums[i] == right {
                i += 1;
                continue;
            }
            if (nums[i] > left && nums[i] > right) || (nums[i] < left && nums[i] < right) {
                count += 1;
            }
            prev = nums[i];
            i += 1;
        }
        count
    }
}