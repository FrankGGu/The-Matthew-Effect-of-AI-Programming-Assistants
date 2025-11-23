impl Solution {
    pub fn is_global_and_local_inversions(nums: Vec<i32>) -> bool {
        for i in 0..nums.len() {
            if nums[i] - i > 1 {
                return false;
            }
        }
        for i in 0..nums.len() - 1 {
            if nums[i] > nums[i + 1] {
                return false;
            }
        }
        true
    }
}