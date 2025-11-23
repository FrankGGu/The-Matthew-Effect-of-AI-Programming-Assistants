impl Solution {
    pub fn is_ideal_permutation(nums: Vec<i32>) -> bool {
        let n = nums.len();
        for i in 0..n {
            if (nums[i] - i as i32).abs() > 1 {
                return false;
            }
        }
        true
    }
}