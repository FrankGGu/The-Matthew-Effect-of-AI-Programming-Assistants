impl Solution {
    pub fn find_median(nums: Vec<i32>) -> f64 {
        let mut unique_nums: Vec<i32> = nums.into_iter().collect();
        unique_nums.sort_unstable();
        unique_nums.dedup();

        let len = unique_nums.len();
        if len % 2 == 1 {
            unique_nums[len / 2] as f64
        } else {
            (unique_nums[len / 2 - 1] + unique_nums[len / 2]) as f64 / 2.0
        }
    }
}