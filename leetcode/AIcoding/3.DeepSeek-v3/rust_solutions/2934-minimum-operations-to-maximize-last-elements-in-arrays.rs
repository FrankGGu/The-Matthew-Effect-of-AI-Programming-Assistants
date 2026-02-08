impl Solution {
    pub fn min_operations(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut res = std::i32::MAX;

        for (a, b) in [(nums1[n - 1], nums2[n - 1]), (nums2[n - 1], nums1[n - 1])] {
            let mut count = 0;
            let mut possible = true;

            for i in 0..n - 1 {
                let x = nums1[i];
                let y = nums2[i];

                if x <= a && y <= b {
                    continue;
                } else if y <= a && x <= b {
                    count += 1;
                } else {
                    possible = false;
                    break;
                }
            }

            if possible {
                res = res.min(count);
            }
        }

        if res == std::i32::MAX {
            -1
        } else {
            res
        }
    }
}