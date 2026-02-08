impl Solution {
    pub fn advantage_shuffle(mut nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let n = nums1.len();

        nums1.sort_unstable();

        let mut indexed_nums2: Vec<(i32, usize)> = nums2
            .into_iter()
            .enumerate()
            .map(|(i, val)| (val, i))
            .collect();
        indexed_nums2.sort_unstable_by_key(|&(val, _)| val);

        let mut ans = vec![0; n];

        let mut nums1_ptr_left = 0;
        let mut nums1_ptr_right = n - 1;

        let mut nums2_ptr_left = 0;
        let mut nums2_ptr_right = n - 1;

        while nums2_ptr_left <= nums2_ptr_right {
            if nums1[nums1_ptr_left] > indexed_nums2[nums2_ptr_left].0 {
                ans[indexed_nums2[nums2_ptr_left].1] = nums1[nums1_ptr_left];
                nums1_ptr_left += 1;
                nums2_ptr_left += 1;
            } else {
                ans[indexed_nums2[nums2_ptr_right].1] = nums1[nums1_ptr_left];
                nums1_ptr_left += 1;
                nums2_ptr_right -= 1;
            }
        }

        ans
    }
}