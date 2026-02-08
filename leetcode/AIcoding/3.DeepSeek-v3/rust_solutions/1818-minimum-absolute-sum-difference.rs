impl Solution {
    pub fn min_absolute_sum_diff(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut sum = 0;
        let n = nums1.len();
        let mut diffs = Vec::with_capacity(n);
        let mut sorted_nums1 = nums1.clone();
        sorted_nums1.sort_unstable();

        for i in 0..n {
            let diff = (nums1[i] - nums2[i]).abs();
            sum = (sum + diff) % 1_000_000_007;
            diffs.push(diff);
        }

        let mut max_reduction = 0;
        for i in 0..n {
            let target = nums2[i];
            let mut left = 0;
            let mut right = n;
            while left < right {
                let mid = left + (right - left) / 2;
                if sorted_nums1[mid] < target {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            let mut min_diff = i32::MAX;
            if left > 0 {
                min_diff = min_diff.min((sorted_nums1[left - 1] - target).abs());
            }
            if left < n {
                min_diff = min_diff.min((sorted_nums1[left] - target).abs());
            }
            let reduction = diffs[i] - min_diff;
            if reduction > max_reduction {
                max_reduction = reduction;
            }
        }

        ((sum as i64 - max_reduction as i64) % 1_000_000_007) as i32
    }
}