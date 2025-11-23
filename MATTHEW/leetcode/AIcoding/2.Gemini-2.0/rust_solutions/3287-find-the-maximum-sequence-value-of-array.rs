impl Solution {
    pub fn max_value_of_sequence(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut ans: i64 = i64::min_value();
        for i in 0..n {
            for j in 0..n {
                for k in 0..n {
                    let val = (nums[i] as i64) * (nums[j] as i64) - (nums[k] as i64);
                    ans = ans.max(val);
                }
            }
        }
        ans
    }
}