impl Solution {
    pub fn make_array_non_decreasing(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        dp[0] = nums[0];

        for i in 1..n {
            if nums[i] >= dp[i - 1] {
                dp[i] = nums[i];
            } else {
                let mut l = 0;
                let mut r = i;
                while l < r {
                    let mid = l + (r - l) / 2;
                    if nums[i] >= dp[mid] {
                        l = mid + 1;
                    } else {
                        r = mid;
                    }
                }
                dp[i] = dp[l - 1];
            }
        }

        let mut tails = vec![i32::MAX; n];
        let mut len = 0;
        for &x in &nums {
            let mut l = 0;
            let mut r = len;
            while l < r {
                let mid = l + (r - l) / 2;
                if tails[mid] <= x {
                    l = mid + 1;
                } else {
                    r = mid;
                }
            }
            tails[l] = x;
            if l == len {
                len += 1;
            }
        }

        (n - len) as i32
    }
}