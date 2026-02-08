impl Solution {
    pub fn count_monotonic_pairs(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            for j in (i + 1)..n {
                if nums[i] <= nums[j] {
                    count += 1;
                }
            }
        }
        count
    }
}