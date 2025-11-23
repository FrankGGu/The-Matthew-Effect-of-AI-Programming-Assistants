impl Solution {
    pub fn min_number(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut min1 = 10;
        let mut min2 = 10;
        let mut min_common = 10;

        let mut seen_in_nums1 = [false; 10];
        let mut seen_in_nums2 = [false; 10];

        for &num in &nums1 {
            min1 = min1.min(num);
            seen_in_nums1[num as usize] = true;
        }

        for &num in &nums2 {
            min2 = min2.min(num);
            seen_in_nums2[num as usize] = true;
        }

        for i in 1..=9 {
            if seen_in_nums1[i] && seen_in_nums2[i] {
                min_common = i as i32;
                break;
            }
        }

        if min_common != 10 {
            min_common
        } else {
            (min1.min(min2) * 10) + min1.max(min2)
        }
    }
}