impl Solution {
    pub fn find_unsorted_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut sorted_nums = nums.clone();
        sorted_nums.sort_unstable();

        let mut left = 0;
        while left < n && nums[left] == sorted_nums[left] {
            left += 1;
        }

        // If left reached n, it means the entire array is sorted.
        if left == n {
            return 0;
        }

        let mut right: isize = (n - 1) as isize;
        while right >= 0 && nums[right as usize] == sorted_nums[right as usize] {
            right -= 1;
        }

        (right - left as isize + 1) as i32
    }
}