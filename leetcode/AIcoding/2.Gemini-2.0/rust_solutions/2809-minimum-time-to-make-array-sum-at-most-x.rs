impl Solution {
    pub fn minimum_time(nums1: Vec<i32>, nums2: Vec<i32>, x: i32) -> i32 {
        let n = nums1.len();
        let mut indices: Vec<usize> = (0..n).collect();
        indices.sort_by_key(|&i| nums2[i]);

        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0;

        let mut sum1 = 0;
        for i in 0..n {
            sum1 += nums1[i] as i64;
        }

        let mut ans = i32::MAX;
        for i in 0..=n {
            if dp[i] != i32::MAX {
                ans = ans.min(dp[i] + x);
            }
        }

        for &i in indices.iter() {
            let num1 = nums1[i];
            let num2 = nums2[i];

            for j in (0..n).rev() {
                if dp[j] != i32::MAX {
                    dp[j + 1] = dp[j + 1].min(dp[j] + num1 + (j as i32 + 1) * num2);
                }
            }
        }

        for i in 0..=n {
            if dp[i] != i32::MAX {
                ans = ans.min(dp[i] + x);
            }
        }

        ans
    }
}