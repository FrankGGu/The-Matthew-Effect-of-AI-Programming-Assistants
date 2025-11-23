struct Solution;

impl Solution {
    pub fn min_swap(mut nums1: Vec<i32>, mut nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut swap = 1;
        let mut no_swap = 0;

        for i in 1..n {
            let mut new_swap = std::i32::MAX;
            let mut new_no_swap = std::i32::MAX;

            if nums1[i] > nums1[i - 1] && nums2[i] > nums2[i - 1] {
                new_no_swap = no_swap;
                new_swap = swap + 1;
            }

            if nums1[i] > nums2[i - 1] && nums2[i] > nums1[i - 1] {
                new_no_swap = std::cmp::min(new_no_swap, swap);
                new_swap = std::cmp::min(new_swap, no_swap + 1);
            }

            swap = new_swap;
            no_swap = new_no_swap;
        }

        std::cmp::min(swap, no_swap)
    }
}