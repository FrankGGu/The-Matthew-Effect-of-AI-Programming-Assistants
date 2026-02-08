impl Solution {
    pub fn min_sum_sq_diff(nums1: Vec<i32>, nums2: Vec<i32>, k1: i32, k2: i32) -> i64 {
        let n = nums1.len();
        let mut k = k1 as i64 + k2 as i64;

        let max_diff_val = 100000;
        let mut counts: Vec<i64> = vec![0; max_diff_val + 1];

        for i in 0..n {
            let diff = (nums1[i] - nums2[i]).abs();
            counts[diff as usize] += 1;
        }

        for d in (1..=max_diff_val).rev() {
            if k == 0 {
                break;
            }
            if counts[d] > 0 {
                let num_to_reduce = counts[d].min(k);

                counts[d] -= num_to_reduce;
                counts[d-1] += num_to_reduce;
                k -= num_to_reduce;
            }
        }

        let mut total_sum_sq: i64 = 0;
        for d in 0..=max_diff_val {
            if counts[d] > 0 {
                total_sum_sq += (d as i64 * d as i64) * counts[d];
            }
        }

        total_sum_sq
    }
}