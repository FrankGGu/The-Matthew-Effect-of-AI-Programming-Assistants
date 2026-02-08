impl Solution {
    pub fn search_insert(nums: Vec<i32>, target: i32) -> i32 {
        let mut low: usize = 0;
        let mut high: usize = nums.len();

        while low < high {
            let mid = low + (high - low) / 2;
            if nums[mid] == target {
                return mid as i32;
            } else if nums[mid] < target {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        low as i32
    }
}