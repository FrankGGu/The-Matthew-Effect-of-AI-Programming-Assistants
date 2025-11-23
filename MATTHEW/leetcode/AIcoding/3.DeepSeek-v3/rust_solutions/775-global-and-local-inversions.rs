impl Solution {
    pub fn is_ideal_permutation(nums: Vec<i32>) -> bool {
        for i in 0..nums.len() {
            if (nums[i] - i as i32).abs() > 1 {
                return false;
            }
        }
        true
    }
}