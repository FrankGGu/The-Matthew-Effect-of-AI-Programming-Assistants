impl Solution {
    pub fn min_operations(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        if k == 0 {
            if nums1 == nums2 {
                return 0;
            } else {
                return -1;
            }
        }

        let mut pos_diff = 0i64;
        let mut neg_diff = 0i64;

        for (a, b) in nums1.iter().zip(nums2.iter()) {
            let diff = a - b;
            if diff % k != 0 {
                return -1;
            }
            let steps = diff / k;
            if steps > 0 {
                pos_diff += steps as i64;
            } else {
                neg_diff += (-steps) as i64;
            }
        }

        if pos_diff == neg_diff {
            pos_diff
        } else {
            -1
        }
    }
}