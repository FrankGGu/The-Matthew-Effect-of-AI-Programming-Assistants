impl Solution {
    pub fn count_almost_equal_pairs(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = nums1.len();

        for i in 0..n {
            for j in 0..n {
                if (nums1[i] - nums2[j]).abs() <= 1 {
                    count += 1;
                }
            }
        }

        count
    }
}