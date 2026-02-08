impl Solution {
    pub fn can_split_array(nums: Vec<i32>, m: i32) -> bool {
        if nums.len() <= 2 {
            return true;
        }

        for i in 0..nums.len() - 1 {
            if nums[i] + nums[i + 1] >= m {
                return true;
            }
        }

        false
    }
}