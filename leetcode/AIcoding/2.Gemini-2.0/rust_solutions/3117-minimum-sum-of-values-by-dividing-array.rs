impl Solution {
    pub fn minimum_sum(nums: Vec<i32>, k: i32) -> i64 {
        let mut nums = nums;
        nums.sort();
        let mut ans = 0i64;
        let mut k = k;
        for &num in &nums {
            if k > 0 && num <= k {
                ans += num as i64;
                k -= num;
            } else if k > 0 {
                ans += k as i64;
                k = 0;
                break;
            }
        }
        if k > 0 {
            ans += (k as i64) * (k as i64 + 1) / 2;
        }
        ans
    }
}