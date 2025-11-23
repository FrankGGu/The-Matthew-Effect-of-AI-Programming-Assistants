impl Solution {
    pub fn max_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let (mut i, mut j) = (0, 0);
        let (n, m) = (nums1.len(), nums2.len());
        let (mut sum1, mut sum2) = (0i64, 0i64);
        let mod_val = 1_000_000_007;

        while i < n || j < m {
            if i < n && (j == m || nums1[i] < nums2[j]) {
                sum1 += nums1[i] as i64;
                i += 1;
            } else if j < m && (i == n || nums2[j] < nums1[i]) {
                sum2 += nums2[j] as i64;
                j += 1;
            } else {
                sum1 = sum1.max(sum2) + nums1[i] as i64;
                sum2 = sum1;
                i += 1;
                j += 1;
            }
        }

        (sum1.max(sum2) % mod_val) as i32
    }
}