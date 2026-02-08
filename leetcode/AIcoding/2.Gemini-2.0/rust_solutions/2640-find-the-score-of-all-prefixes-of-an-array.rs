impl Solution {
    pub fn find_the_score_of_all_prefixes(nums: Vec<i32>) -> Vec<i64> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut max_val = nums[0];
        result[0] = nums[0] as i64 + max_val as i64;
        for i in 1..n {
            max_val = max_val.max(nums[i]);
            result[i] = result[i - 1] + nums[i] as i64 + max_val as i64;
        }
        result
    }
}