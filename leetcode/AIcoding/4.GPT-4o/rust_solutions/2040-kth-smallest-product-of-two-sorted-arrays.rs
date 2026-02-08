impl Solution {
    pub fn kth_smallest_product(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        let (m, n) = (nums1.len() as i64, nums2.len() as i64);
        let (mut left, mut right) = (1, (nums1[m as usize - 1] as i64) * (nums2[n as usize - 1] as i64));

        while left < right {
            let mid = left + (right - left) / 2;
            let mut count = 0;
            let mut j = n - 1;

            for &num in &nums1 {
                while j >= 0 && num as i64 * (nums2[j as usize] as i64) > mid {
                    j -= 1;
                }
                count += (j + 1) as i64;
            }

            if count < k as i64 {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}