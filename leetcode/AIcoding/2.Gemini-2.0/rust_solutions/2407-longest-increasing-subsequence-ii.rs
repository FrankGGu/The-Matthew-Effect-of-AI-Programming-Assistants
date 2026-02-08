impl Solution {
    pub fn length_of_lis(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp: Vec<i32> = Vec::new();

        for &num in &nums {
            let mut l = 0;
            let mut r = dp.len();

            while l < r {
                let mid = l + (r - l) / 2;
                if dp[mid] < num {
                    l = mid + 1;
                } else {
                    r = mid;
                }
            }

            if l == 0 || (l > 0 && num - dp[l - 1] <= k) {
                if l == dp.len() {
                    dp.push(num);
                } else {
                    dp[l] = num;
                }
            }
        }

        dp.len() as i32
    }
}