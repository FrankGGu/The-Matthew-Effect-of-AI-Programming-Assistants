impl Solution {
    pub fn min_operations(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        let n = nums1.len();

        if k == 0 {
            for i in 0..n {
                if nums1[i] != nums2[i] {
                    return -1;
                }
            }
            return 0;
        }

        let mut total_diff_sum: i64 = 0;
        let mut operations_count: i64 = 0;

        for i in 0..n {
            let diff = nums1[i] - nums2[i]; 

            if diff % k != 0 {
                return -1;
            }

            total_diff_sum += diff as i64;

            if diff > 0 {
                operations_count += (diff / k) as i64;
            }
        }

        if total_diff_sum != 0 {
            return -1;
        }

        operations_count
    }
}