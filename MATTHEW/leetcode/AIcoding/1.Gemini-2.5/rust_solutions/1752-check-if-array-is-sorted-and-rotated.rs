impl Solution {
    pub fn check(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut break_count = 0;

        for i in 0..n - 1 {
            if nums[i] > nums[i + 1] {
                break_count += 1;
            }
        }

        if break_count == 0 {
            true
        } else if break_count == 1 {
            nums[n - 1] <= nums[0]
        } else {
            false
        }
    }
}