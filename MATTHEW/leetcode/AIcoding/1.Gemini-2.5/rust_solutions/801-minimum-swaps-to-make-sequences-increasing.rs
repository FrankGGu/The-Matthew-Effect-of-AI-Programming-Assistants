impl Solution {
    pub fn min_swap(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();

        let mut prev_no_swap = 0;
        let mut prev_swap = 1;

        for i in 1..n {
            let mut curr_no_swap = i32::MAX;
            let mut curr_swap = i32::MAX;

            // Case 1: Don't swap nums1[i] and nums2[i]
            // Subcase 1.1: nums1[i-1] and nums2[i-1] were NOT swapped
            if nums1[i - 1] < nums1[i] && nums2[i - 1] < nums2[i] {
                curr_no_swap = curr_no_swap.min(prev_no_swap);
            }
            // Subcase 1.2: nums1[i-1] and nums2[i-1] WERE swapped
            if nums2[i - 1] < nums1[i] && nums1[i - 1] < nums2[i] {
                curr_no_swap = curr_no_swap.min(prev_swap);
            }

            // Case 2: Swap nums1[i] and nums2[i]
            // Subcase 2.1: nums1[i-1] and nums2[i-1] were NOT swapped
            if nums1[i - 1] < nums2[i] && nums2[i - 1] < nums1[i] {
                curr_swap = curr_swap.min(prev_no_swap + 1);
            }
            // Subcase 2.2: nums1[i-1] and nums2[i-1] WERE swapped
            if nums2[i - 1] < nums2[i] && nums1[i - 1] < nums1[i] {
                curr_swap = curr_swap.min(prev_swap + 1);
            }

            prev_no_swap = curr_no_swap;
            prev_swap = curr_swap;
        }

        prev_no_swap.min(prev_swap)
    }
}