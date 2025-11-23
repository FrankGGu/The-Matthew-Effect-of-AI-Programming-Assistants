impl Solution {
    pub fn search(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();
        let mut low = 0;
        let mut high = n - 1;

        while low <= high {
            let mid = low + (high - low) / 2;

            if nums[mid] == target {
                return mid as i32;
            }

            if nums[low] <= nums[mid] {
                if nums[low] <= target && target < nums[mid] {
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            } else {
                if nums[mid] < target && target <= nums[high] {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
        }

        -1
    }
}