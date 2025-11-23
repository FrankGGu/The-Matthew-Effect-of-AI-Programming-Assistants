struct Solution;

impl Solution {
    pub fn check_sorted_and_rotated(nums: Vec<i32>) -> bool {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            if nums[i] > nums[(i + 1) % n] {
                count += 1;
                if count > 1 {
                    return false;
                }
            }
        }
        true
    }
}