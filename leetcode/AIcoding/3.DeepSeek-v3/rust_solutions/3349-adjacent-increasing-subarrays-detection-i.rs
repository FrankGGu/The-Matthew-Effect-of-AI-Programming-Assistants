impl Solution {
    pub fn can_split_array(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n <= 2 {
            return true;
        }
        for i in 1..n {
            let sum_left: i32 = nums[..i].iter().sum();
            let sum_right: i32 = nums[i..].iter().sum();
            if sum_left < sum_right {
                return true;
            }
        }
        false
    }
}