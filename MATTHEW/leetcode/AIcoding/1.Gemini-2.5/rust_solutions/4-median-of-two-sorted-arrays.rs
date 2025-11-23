impl Solution {
    pub fn find_median_sorted_arrays(nums1: Vec<i32>, nums2: Vec<i32>) -> f64 {
        let m = nums1.len();
        let n = nums2.len();
        let total_len = m + n;

        if total_len % 2 == 1 {
            Self::find_kth(&nums1, &nums2, total_len / 2 + 1) as f64
        } else {
            let mid1 = Self::find_kth(&nums1, &nums2, total_len / 2);
            let mid2 = Self::find_kth(&nums1, &nums2, total_len / 2 + 1);
            (mid1 + mid2) as f64 / 2.0
        }
    }

    fn find_kth(nums1: &[i32], nums2: &[i32], k: usize) -> i32 {
        let m = nums1.len();
        let n = nums2.len();

        if m > n {
            return Self::find_kth(nums2, nums1, k);
        }

        if m == 0 {
            return nums2[k - 1];
        }

        if k == 1 {
            return nums1[0].min(nums2[0]);
        }

        let pa = (k / 2).min(m);
        let pb = k - pa;

        if nums1[pa - 1] < nums2[pb - 1] {
            Self::find_kth(&nums1[pa..], nums2, k - pa)
        } else {
            Self::find_kth(nums1, &nums2[pb..], k - pb)
        }
    }
}