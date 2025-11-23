impl Solution {
    pub fn min_swap(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut swap = 1;
        let mut no_swap = 0;

        for i in 1..n {
            let mut new_swap = n as i32;
            let mut new_no_swap = n as i32;

            if nums1[i] > nums1[i-1] && nums2[i] > nums2[i-1] {
                new_swap = new_swap.min(swap + 1);
                new_no_swap = new_no_swap.min(no_swap);
            }
            if nums1[i] > nums2[i-1] && nums2[i] > nums1[i-1] {
                new_swap = new_swap.min(no_swap + 1);
                new_no_swap = new_no_swap.min(swap);
            }

            swap = new_swap;
            no_swap = new_no_swap;
        }

        swap.min(no_swap)
    }
}