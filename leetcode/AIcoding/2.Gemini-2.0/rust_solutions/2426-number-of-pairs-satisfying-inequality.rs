use std::collections::HashMap;

impl Solution {
    pub fn number_of_pairs(nums1: Vec<i32>, nums2: Vec<i32>, diff: i32) -> i64 {
        let n = nums1.len();
        let mut nums = Vec::with_capacity(n);
        for i in 0..n {
            nums.push(nums1[i] - nums2[i]);
        }

        let mut count = 0i64;
        let mut sorted: Vec<i32> = Vec::new();

        for &num in nums.iter() {
            let target = num + diff;
            let mut left = 0;
            let mut right = sorted.len();
            let mut index = sorted.len();
            while left < right {
                let mid = left + (right - left) / 2;
                if sorted[mid] <= target {
                    left = mid + 1;
                } else {
                    index = mid;
                    right = mid;
                }
            }
            count += index as i64;

            let mut insert_index = 0;
            let mut left = 0;
            let mut right = sorted.len();
            while left < right {
                let mid = left + (right - left) / 2;
                if sorted[mid] < num {
                    left = mid + 1;
                } else {
                    insert_index = mid;
                    right = mid;
                }
            }
            sorted.insert(insert_index, num);
        }

        count
    }
}