impl Solution {
    pub fn max_score(nums1: Vec<i332>, nums2: Vec<i32>) -> i32 {
        let n1 = nums1.len();
        let n2 = nums2.len();
        let modulo: i64 = 1_000_000_007;

        let mut i = 0;
        let mut j = 0;
        let mut sum1: i64 = 0;
        let mut sum2: i64 = 0;

        while i < n1 && j < n2 {
            if nums1[i] < nums2[j] {
                sum1 = (sum1 + nums1[i] as i64) % modulo;
                i += 1;
            } else if nums1[i] > nums2[j] {
                sum2 = (sum2 + nums2[j] as i64) % modulo;
                j += 1;
            } else { // nums1[i] == nums2[j]
                let common_val = nums1[i] as i64;
                let max_prev_sum = sum1.max(sum2);
                sum1 = (max_prev_sum + common_val) % modulo;
                sum2 = (max_prev_sum + common_val) % modulo;
                i += 1;
                j += 1;
            }
        }

        // Add remaining elements from nums1
        while i < n1 {
            sum1 = (sum1 + nums1[i] as i64) % modulo;
            i += 1;
        }

        // Add remaining elements from nums2
        while j < n2 {
            sum2 = (sum2 + nums2[j] as i64) % modulo;
            j += 1;
        }

        (sum1.max(sum2)) as i32
    }
}