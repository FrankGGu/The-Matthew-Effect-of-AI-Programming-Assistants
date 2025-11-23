impl Solution {

use std::cmp::max;

struct Solution {}

impl Solution {
    pub fn minimize_max(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut nums1 = nums1;
        let mut nums2 = nums2;
        nums1.sort();
        nums2.sort();

        let mut left = 0;
        let mut right = max(nums1.last().unwrap(), nums2.last().unwrap()) - min(nums1.first().unwrap(), nums2.first().unwrap());

        while left < right {
            let mid = left + (right - left) / 2;
            if Self::can_achieve(nums1.clone(), nums2.clone(), mid) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }

    fn can_achieve(mut nums1: Vec<i32>, mut nums2: Vec<i32>, limit: i32) -> bool {
        let mut i = 0;
        let mut j = 0;
        while i < nums1.len() && j < nums2.len() {
            if nums1[i] <= nums2[j] + limit {
                i += 1;
            }
            if nums2[j] <= nums1[i] + limit {
                j += 1;
            }
        }
        i == nums1.len() && j == nums2.len()
    }
}
}