impl Solution {
    pub fn minimize_array_value(nums: Vec<i32>) -> i32 {
        let mut sum: i64 = 0;
        let mut ans: i64 = 0;
        for (i, &num) in nums.iter().enumerate() {
            sum += num as i64;
            ans = ans.max((sum + i as i64) / (i as i64 + 1));
        }
        ans as i32
    }
}