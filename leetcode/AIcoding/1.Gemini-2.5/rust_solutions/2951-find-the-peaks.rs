impl Solution {
    pub fn find_peaks(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut peaks = Vec::new();

        for i in 1..n - 1 {
            if nums[i] > nums[i - 1] && nums[i] > nums[i + 1] {
                peaks.push(i as i32);
            }
        }

        peaks
    }
}