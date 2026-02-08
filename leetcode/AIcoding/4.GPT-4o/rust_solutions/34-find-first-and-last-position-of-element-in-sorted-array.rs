impl Solution {
    pub fn search_range(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let first = Self::find_first(&nums, target);
        let last = Self::find_last(&nums, target);
        vec![first, last]
    }

    fn find_first(nums: &Vec<i32>, target: i32) -> i32 {
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;
        let mut result = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if nums[mid as usize] == target {
                result = mid;
                right = mid - 1;
            } else if nums[mid as usize] < target {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result
    }

    fn find_last(nums: &Vec<i32>, target: i32) -> i32 {
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;
        let mut result = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if nums[mid as usize] == target {
                result = mid;
                left = mid + 1;
            } else if nums[mid as usize] < target {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result
    }
}