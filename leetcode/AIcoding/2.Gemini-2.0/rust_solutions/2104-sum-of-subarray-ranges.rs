impl Solution {
    pub fn sub_array_ranges(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut sum_ranges: i64 = 0;

        for i in 0..n {
            let mut min_val = nums[i];
            let mut max_val = nums[i];

            for j in i + 1..n {
                min_val = min_val.min(nums[j]);
                max_val = max_val.max(nums[j]);
                sum_ranges += (max_val as i64) - (min_val as i64);
            }
        }

        sum_ranges
    }
}