impl Solution {
    pub fn maximums_spliced_array(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let sum1: i32 = nums1.iter().sum();
        let sum2: i32 = nums2.iter().sum();

        let diff1: Vec<i32> = nums2.iter().zip(nums1.iter()).map(|(&a, &b)| a - b).collect();
        let diff2: Vec<i32> = nums1.iter().zip(nums2.iter()).map(|(&a, &b)| a - b).collect();

        let max_diff1 = Self::kadane(&diff1);
        let max_diff2 = Self::kadane(&diff2);

        std::cmp::max(sum1 + max_diff1, sum2 + max_diff2)
    }

    fn kadane(nums: &[i32]) -> i32 {
        let mut max_current = nums[0];
        let mut max_global = nums[0];

        for &num in nums.iter().skip(1) {
            max_current = std::cmp::max(num, max_current + num);
            max_global = std::cmp::max(max_global, max_current);
        }

        std::cmp::max(max_global, 0)
    }
}