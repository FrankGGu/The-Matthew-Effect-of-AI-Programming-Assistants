impl Solution {
    pub fn min_swap(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut swap = vec![0; n];
        let mut no_swap = vec![0; n];

        swap[0] = 1;

        for i in 1..n {
            no_swap[i] = i32::MAX;
            swap[i] = i32::MAX;

            if nums1[i] > nums1[i - 1] && nums2[i] > nums2[i - 1] {
                no_swap[i] = no_swap[i].min(no_swap[i - 1]);
                swap[i] = swap[i].min(swap[i - 1] + 1);
            }

            if nums1[i] > nums2[i - 1] && nums2[i] > nums1[i - 1] {
                no_swap[i] = no_swap[i].min(swap[i - 1]);
                swap[i] = swap[i].min(no_swap[i - 1] + 1);
            }
        }

        no_swap[n - 1].min(swap[n - 1])
    }
}