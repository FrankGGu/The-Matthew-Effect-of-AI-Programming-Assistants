impl Solution {
    pub fn get_max_score(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n1 = nums1.len();
        let n2 = nums2.len();
        let mut i = 0;
        let mut j = 0;
        let mut sum1: i64 = 0;
        let mut sum2: i64 = 0;
        let mut ans: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        while i < n1 || j < n2 {
            if i < n1 && (j == n2 || nums1[i] < nums2[j]) {
                sum1 += nums1[i] as i64;
                i += 1;
            } else if j < n2 && (i == n1 || nums2[j] < nums1[i]) {
                sum2 += nums2[j] as i64;
                j += 1;
            } else {
                ans += std::cmp::max(sum1, sum2);
                ans %= modulo;
                sum1 = 0;
                sum2 = 0;
                ans += nums1[i] as i64;
                ans %= modulo;
                i += 1;
                j += 1;
            }
        }

        ans += std::cmp::max(sum1, sum2);
        ans %= modulo;

        ans as i32
    }
}