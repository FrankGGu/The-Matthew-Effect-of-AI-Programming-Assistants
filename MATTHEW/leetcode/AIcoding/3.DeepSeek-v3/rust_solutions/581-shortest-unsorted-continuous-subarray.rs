impl Solution {
    pub fn find_unsorted_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut left = n;
        let mut right = 0;
        let mut min = i32::MAX;
        let mut max = i32::MIN;

        for i in 0..n {
            if nums[i] < max {
                right = i;
            } else {
                max = nums[i];
            }
        }

        for i in (0..n).rev() {
            if nums[i] > min {
                left = i;
            } else {
                min = nums[i];
            }
        }

        if right > left {
            (right - left + 1) as i32
        } else {
            0
        }
    }
}