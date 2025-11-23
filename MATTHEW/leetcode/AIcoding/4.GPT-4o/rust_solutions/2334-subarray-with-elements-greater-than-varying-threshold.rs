impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, threshold: i32) -> i32 {
        let mut count = 0;
        let mut start = 0;
        for end in 0..nums.len() {
            if nums[end] > threshold {
                count += (end - start + 1) * (end - start + 1);
                start = end + 1;
            }
        }
        count += (nums.len() - start) * (nums.len() - start + 1) / 2;
        count
    }
}