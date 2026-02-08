impl Solution {
    pub fn continuous_subarrays(nums: Vec<i32>) -> i64 {
        let mut count: i64 = 0;
        let n = nums.len();
        for i in 0..n {
            let mut min_val = nums[i];
            let mut max_val = nums[i];
            for j in i..n {
                min_val = min_val.min(nums[j]);
                max_val = max_val.max(nums[j]);
                if max_val - min_val <= 2 {
                    count += 1;
                } else {
                    break;
                }
            }
        }
        count
    }
}