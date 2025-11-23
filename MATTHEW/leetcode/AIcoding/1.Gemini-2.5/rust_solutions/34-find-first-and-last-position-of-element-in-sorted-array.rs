impl Solution {
    pub fn search_range(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let left_idx = Self::find_leftmost(&nums, target);
        let right_idx = Self::find_rightmost(&nums, target);
        vec![left_idx, right_idx]
    }

    fn find_leftmost(nums: &[i32], target: i32) -> i32 {
        let mut low: usize = 0;
        let mut high: usize = nums.len();
        let mut ans: i32 = -1;

        while low < high {
            let mid = low + (high - low) / 2;
            if nums[mid] < target {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        if low < nums.len() && nums[low] == target {
            ans = low as i32;
        }
        ans
    }

    fn find_rightmost(nums: &[i32], target: i32) -> i32 {
        let mut low: usize = 0;
        let mut high: usize = nums.len();
        let mut ans: i32 = -1;

        while low < high {
            let mid = low + (high - low) / 2;
            if nums[mid] > target {
                high = mid;
            } else {
                low = mid + 1;
            }
        }

        let right_idx = low as isize - 1;
        if right_idx >= 0 && (right_idx as usize) < nums.len() && nums[right_idx as usize] == target {
            ans = right_idx as i32;
        }
        ans
    }
}