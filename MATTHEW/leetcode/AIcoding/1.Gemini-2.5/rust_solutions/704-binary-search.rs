impl Solution {
    pub fn search(nums: Vec<i32>, target: i32) -> i32 {
        let mut left: usize = 0;
        let mut right: usize = nums.len(); // Exclusive right bound

        while left < right {
            let mid: usize = left + (right - left) / 2;

            if nums[mid] == target {
                return mid as i32;
            } else if nums[mid] < target {
                left = mid + 1;
            } else { // nums[mid] > target
                right = mid;
            }
        }

        -1
    }
}