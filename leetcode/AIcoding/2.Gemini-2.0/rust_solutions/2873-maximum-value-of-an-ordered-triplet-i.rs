impl Solution {
    pub fn maximum_value(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut max_val: i64 = 0;
        for i in 0..n {
            for j in i + 1..n {
                for k in j + 1..n {
                    let val: i64 = (nums[i] as i64 - nums[j] as i64) * nums[k] as i64;
                    max_val = max_val.max(val);
                }
            }
        }
        max_val
    }
}