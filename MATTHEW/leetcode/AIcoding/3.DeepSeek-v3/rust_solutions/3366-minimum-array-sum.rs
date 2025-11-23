impl Solution {
    pub fn min_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i64 {
        let sum1: i64 = nums1.iter().map(|&x| x as i64).sum();
        let sum2: i64 = nums2.iter().map(|&x| x as i64).sum();

        let zero1 = nums1.iter().filter(|&&x| x == 0).count() as i64;
        let zero2 = nums2.iter().filter(|&&x| x == 0).count() as i64;

        if zero1 == 0 && zero2 == 0 {
            if sum1 != sum2 {
                return -1;
            } else {
                return sum1;
            }
        }

        if zero1 == 0 {
            if sum1 < sum2 + zero2 {
                return -1;
            } else {
                return sum1;
            }
        }

        if zero2 == 0 {
            if sum2 < sum1 + zero1 {
                return -1;
            } else {
                return sum2;
            }
        }

        std::cmp::max(sum1 + zero1, sum2 + zero2)
    }
}