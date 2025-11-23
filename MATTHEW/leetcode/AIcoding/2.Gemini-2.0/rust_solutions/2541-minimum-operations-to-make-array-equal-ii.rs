impl Solution {
    pub fn min_operations(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        if k == 0 {
            if nums1 == nums2 {
                return 0;
            } else {
                return -1;
            }
        }

        let mut inc: i64 = 0;
        let mut dec: i64 = 0;

        for i in 0..nums1.len() {
            let diff = nums1[i] - nums2[i];
            if diff % k != 0 {
                return -1;
            }
            if diff > 0 {
                inc += diff as i64;
            } else if diff < 0 {
                dec += (-diff) as i64;
            }
        }

        if inc == dec {
            return inc / k as i64;
        } else {
            return -1;
        }
    }
}