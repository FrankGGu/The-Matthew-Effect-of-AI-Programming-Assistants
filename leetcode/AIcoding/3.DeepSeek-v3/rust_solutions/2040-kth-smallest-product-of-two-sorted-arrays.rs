impl Solution {
    pub fn kth_smallest_product(nums1: Vec<i32>, nums2: Vec<i32>, k: i64) -> i64 {
        let (nums1, nums2) = if nums1.len() > nums2.len() {
            (nums2, nums1)
        } else {
            (nums1, nums2)
        };

        let (m, n) = (nums1.len(), nums2.len());
        let mut left = i64::MIN;
        let mut right = i64::MAX;

        while left < right {
            let mid = left + (right - left) / 2;
            let mut count = 0;

            for &num in &nums1 {
                if num == 0 {
                    if mid >= 0 {
                        count += n as i64;
                    }
                    continue;
                }

                let target = mid / num as i64;
                if num > 0 {
                    let idx = nums2.partition_point(|&x| x as i64 <= target);
                    count += idx as i64;
                } else {
                    let idx = nums2.partition_point(|&x| x as i64 >= target);
                    count += (n - idx) as i64;
                }
            }

            if count < k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}