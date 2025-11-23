impl Solution {
    pub fn zero_filled_subarray(nums: Vec<i32>) -> i64 {
        let mut count = 0;
        let mut ans = 0;
        for &num in &nums {
            if num == 0 {
                count += 1;
                ans += count;
            } else {
                count = 0;
            }
        }
        ans
    }
}