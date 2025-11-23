impl Solution {
    pub fn can_split_array(nums: Vec<i32>, m: i32) -> bool {
        let n = nums.len();
        if n < 2 { return true; }
        let mut count = 1;
        for i in 1..n {
            if nums[i] + nums[i - 1] <= m {
                count += 1;
            } else {
                count = 1;
            }
            if count >= 2 { return true; }
        }
        false
    }
}