impl Solution {
    pub fn search_range(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let left = Self::binary_search(&nums, target, true);
        let right = Self::binary_search(&nums, target, false);
        vec![left, right]
    }

    fn binary_search(nums: &Vec<i32>, target: i32, left_most: bool) -> i32 {
        let mut low = 0;
        let mut high = nums.len() as i32 - 1;
        let mut res = -1;

        while low <= high {
            let mid = low + (high - low) / 2;
            if nums[mid as usize] == target {
                res = mid;
                if left_most {
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            } else if nums[mid as usize] < target {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        res
    }
}