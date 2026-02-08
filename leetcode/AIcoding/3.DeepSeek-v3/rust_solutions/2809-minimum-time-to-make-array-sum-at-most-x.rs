impl Solution {
    pub fn minimum_time(nums1: Vec<i32>, nums2: Vec<i32>, x: i32) -> i32 {
        let n = nums1.len();
        let mut pairs: Vec<_> = nums1.iter().zip(nums2.iter()).collect();
        pairs.sort_by(|a, b| a.1.cmp(b.1));

        let mut dp = vec![0; n + 1];
        for (i, (&a, &b)) in pairs.iter().enumerate() {
            for j in (1..=i + 1).rev() {
                dp[j] = dp[j].max(dp[j - 1] + a + b * j as i32);
            }
        }

        let sum1: i32 = nums1.iter().sum();
        let sum2: i32 = nums2.iter().sum();

        for t in 0..=n {
            if sum1 + sum2 * t as i32 - dp[t] <= x {
                return t as i32;
            }
        }

        -1
    }
}