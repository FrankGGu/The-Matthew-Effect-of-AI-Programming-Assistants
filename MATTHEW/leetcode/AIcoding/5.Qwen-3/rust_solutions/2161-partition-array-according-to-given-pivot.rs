struct Solution;

impl Solution {
    pub fn pivot_array(mut nums: Vec<i32>, pivot: i32) -> Vec<i32> {
        let mut left = 0;
        let mut right = nums.len() - 1;

        while left < right {
            while left < right && nums[left] < pivot {
                left += 1;
            }
            while left < right && nums[right] > pivot {
                right -= 1;
            }
            if left < right {
                nums.swap(left, right);
                left += 1;
                right -= 1;
            }
        }

        left = 0;
        right = nums.len() - 1;

        while left < right {
            while left < right && nums[left] <= pivot {
                left += 1;
            }
            while left < right && nums[right] >= pivot {
                right -= 1;
            }
            if left < right {
                nums.swap(left, right);
                left += 1;
                right -= 1;
            }
        }

        nums
    }
}