impl Solution {
    pub fn is_monotonic(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n <= 1 {
            return true;
        }

        let mut increasing = true;
        let mut decreasing = true;

        for i in 1..n {
            if nums[i] > nums[i - 1] {
                decreasing = false;
            } else if nums[i] < nums[i - 1] {
                increasing = false;
            }
        }

        increasing || decreasing
    }
}