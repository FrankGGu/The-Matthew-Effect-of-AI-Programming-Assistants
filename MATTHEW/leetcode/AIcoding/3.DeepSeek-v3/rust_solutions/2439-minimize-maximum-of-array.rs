impl Solution {
    pub fn minimize_array_value(nums: Vec<i32>) -> i32 {
        let mut res = 0;
        let mut sum: i64 = 0;
        for i in 0..nums.len() {
            sum += nums[i] as i64;
            let avg = (sum + i as i64) / (i as i64 + 1);
            res = res.max(avg as i32);
        }
        res
    }
}