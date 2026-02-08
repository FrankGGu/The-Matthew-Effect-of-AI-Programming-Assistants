impl Solution {
    pub fn kth_smallest_product(nums1: Vec<i32>, nums2: Vec<i32>, k: i64) -> i64 {
        let n = nums1.len();
        let m = nums2.len();

        let mut low: i64 = -1_000_000_000_0;
        let mut high: i64 = 1_000_000_000_0;
        let mut ans: i64 = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::count_le(mid, &nums1, &nums2) >= k {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn count_le(target: i64, nums1: &[i32], nums2: &[i32]) -> i64 {
        let mut count = 0;
        let n2_len = nums2.len() as i64;

        for &n1 in nums1 {
            if n1 == 0 {
                if target >= 0 {
                    count += n2_len;
                }
            } else if n1 > 0 {
                let limit = target.div_euclid(n1 as i64);

                let idx = nums2.partition_point(|&x| x as i64 <= limit);
                count += idx as i64;
            } else { // n1 < 0
                let limit = (target as f64 / n1 as f64).ceil() as i64;

                let idx = nums2.partition_point(|&x| x as i64 < limit);
                count += n2_len - idx as i64;
            }
        }
        count
    }
}