use std::collections::HashSet;

impl Solution {
    pub fn maximum_size(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut s1: HashSet<i32> = nums1.into_iter().collect();
        let mut s2: HashSet<i32> = nums2.into_iter().collect();
        let mut intersection: HashSet<i32> = s1.intersection(&s2).cloned().collect();

        let mut s1_only: HashSet<i32> = s1.difference(&intersection).cloned().collect();
        let mut s2_only: HashSet<i32> = s2.difference(&intersection).cloned().collect();

        let mut ans = 0;

        let half = n as i32;

        let s1_only_size = s1_only.len() as i32;
        let s2_only_size = s2_only.len() as i32;
        let intersection_size = intersection.len() as i32;

        ans += std::cmp::min(s1_only_size, half);
        ans += std::cmp::min(s2_only_size, half);

        let remaining = 2 * half - ans;

        ans += std::cmp::min(intersection_size, remaining);

        ans
    }
}