impl Solution {
    pub fn search_range(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let first = Self::find_first(&nums, target);
        let last = Self::find_last(&nums, target);
        vec![first, last]
    }

    fn find_first(nums: &Vec<i32>, target: i32) -> i32 {
        let mut low = 0;
        let mut high = nums.len() as i32 - 1;
        let mut result = -1;

        while low <= high as usize {
            let mid = low + (high as usize - low) / 2;
            if nums[mid] == target {
                result = mid as i32;
                high = mid as i32 - 1;
            } else if nums[mid] < target {
                low = mid + 1;
            } else {
                high = mid as i32 - 1;
            }
        }
        result
    }

    fn find_last(nums: &Vec<i32>, target: i32) -> i32 {
        let mut low = 0;
        let mut high = nums.len() as i32 - 1;
        let mut result = -1;

        while low <= high as usize {
            let mid = low + (high as usize - low) / 2;
            if nums[mid] == target {
                result = mid as i32;
                low = mid + 1;
            } else if nums[mid] < target {
                low = mid + 1;
            } else {
                high = mid as i32 - 1;
            }
        }
        result
    }
}