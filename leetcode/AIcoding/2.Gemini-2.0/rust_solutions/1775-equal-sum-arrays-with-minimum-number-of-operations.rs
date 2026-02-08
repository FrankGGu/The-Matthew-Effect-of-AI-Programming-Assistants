impl Solution {
    pub fn min_operations(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n1 = nums1.len();
        let n2 = nums2.len();

        if n1 > n2 * 6 || n2 > n1 * 6 {
            return -1;
        }

        let sum1: i32 = nums1.iter().sum();
        let sum2: i32 = nums2.iter().sum();

        if sum1 == sum2 {
            return 0;
        }

        let (mut nums_small, mut nums_big, mut diff) = if sum1 < sum2 {
            (nums1, nums2, sum2 - sum1)
        } else {
            (nums2, nums1, sum1 - sum2)
        };

        nums_small.sort();
        nums_big.sort_by(|a, b| b.cmp(a));

        let mut i = 0;
        let mut j = 0;
        let mut ops = 0;

        while diff > 0 {
            let op1 = if i < nums_small.len() {
                6 - nums_small[i]
            } else {
                -1
            };

            let op2 = if j < nums_big.len() {
                nums_big[j] - 1
            } else {
                -1
            };

            if op1 >= op2 {
                diff -= op1;
                i += 1;
            } else {
                diff -= op2;
                j += 1;
            }

            ops += 1;
        }

        ops
    }
}