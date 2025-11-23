impl Solution {
    pub fn max_operations(nums: Vec<i32>) -> i32 {
        if nums.len() < 2 {
            return 0;
        }
        let target = nums[0] + nums[1];
        let mut count = 1;
        let mut i = 2;
        while i + 1 <= nums.len() {
            if nums[i] + nums[i + 1] == target {
                count += 1;
                i += 2;
            } else {
                break;
            }
        }
        count
    }
}