impl Solution {
    pub fn find_common_elements(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut in_nums1 = vec![false; 1001];
        let mut in_nums2 = vec![false; 1001];

        for &num in &nums1 {
            in_nums1[num as usize] = true;
        }

        for &num in &nums2 {
            in_nums2[num as usize] = true;
        }

        let mut count1 = 0;
        for &num in &nums1 {
            if in_nums2[num as usize] {
                count1 += 1;
            }
        }

        let mut count2 = 0;
        for &num in &nums2 {
            if in_nums1[num as usize] {
                count2 += 1;
            }
        }

        vec![count1, count2]
    }
}