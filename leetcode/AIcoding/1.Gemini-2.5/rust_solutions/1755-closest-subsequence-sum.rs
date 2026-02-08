use std::cmp::min;

impl Solution {
    pub fn min_abs_sum_diff(nums: Vec<i32>, goal: i32) -> i32 {
        let n = nums.len();
        if n == 0 {
            return goal.abs();
        }

        let mid = n / 2;
        let nums1 = &nums[0..mid];
        let nums2 = &nums[mid..n];

        let sums1 = Self::generate_sums(nums1);
        let mut sums2 = Self::generate_sums(nums2);

        sums2.sort_unstable();

        let mut min_diff = i32::MAX;

        for s1 in sums1 {
            let target_s2 = goal - s1;

            match sums2.binary_search(&target_s2) {
                Ok(_) => {
                    return 0;
                }
                Err(idx) => {
                    if idx < sums2.len() {
                        let current_sum = s1 + sums2[idx];
                        min_diff = min_diff.min((current_sum - goal).abs());
                    }
                    if idx > 0 {
                        let current_sum = s1 + sums2[idx - 1];
                        min_diff = min_diff.min((current_sum - goal).abs());
                    }
                }
            }
        }

        min_diff
    }

    fn generate_sums(arr: &[i32]) -> Vec<i32> {
        let mut sums = Vec::with_capacity(1 << arr.len());
        sums.push(0);

        for &num in arr {
            let current_len = sums.len();
            for i in 0..current_len {
                sums.push(sums[i] + num);
            }
        }
        sums
    }
}