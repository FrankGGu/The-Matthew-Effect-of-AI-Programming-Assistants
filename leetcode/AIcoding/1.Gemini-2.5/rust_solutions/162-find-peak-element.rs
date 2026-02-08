impl Solution {
    pub fn find_peak_element(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut low: usize = 0;
        let mut high: usize = n - 1;

        while low < high {
            let mid: usize = low + (high - low) / 2;
            if nums[mid] > nums[mid + 1] {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        low as i32
    }
}