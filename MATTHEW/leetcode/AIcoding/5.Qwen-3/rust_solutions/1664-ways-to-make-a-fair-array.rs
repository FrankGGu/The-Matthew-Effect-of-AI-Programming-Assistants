impl Solution {
    pub fn ways_to_make_fair(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left_even = 0;
        let mut left_odd = 0;
        let mut right_even = 0;
        let mut right_odd = 0;

        for i in 0..n {
            if i % 2 == 0 {
                right_even += nums[i];
            } else {
                right_odd += nums[i];
            }
        }

        let mut result = 0;

        for i in 0..n {
            if i % 2 == 0 {
                right_even -= nums[i];
            } else {
                right_odd -= nums[i];
            }

            if left_even + right_odd == left_odd + right_even {
                result += 1;
            }

            if i % 2 == 0 {
                left_even += nums[i];
            } else {
                left_odd += nums[i];
            }
        }

        result
    }
}