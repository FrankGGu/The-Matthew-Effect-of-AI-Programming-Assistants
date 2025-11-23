impl Solution {
    pub fn advantage_count(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let n = nums1.len();
        let mut nums1_sorted = nums1.clone();
        nums1_sorted.sort();
        let mut nums2_indexed: Vec<(usize, i32)> = nums2.iter().enumerate().map(|(i, &x)| (i, x)).collect();
        nums2_indexed.sort_by_key(|&(_, x)| x);

        let mut result = vec![0; n];
        let mut left = 0;
        let mut right = n - 1;

        for num1 in nums1_sorted {
            if num1 > nums2_indexed[left].1 {
                result[nums2_indexed[left].0] = num1;
                left += 1;
            } else {
                result[nums2_indexed[right].0] = num1;
                right -= 1;
            }
        }

        result
    }
}