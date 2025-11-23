use std::collections::HashMap;

impl Solution {
    pub fn minimum_total_cost(nums1: Vec<i32>, nums2: Vec<i32>) -> i64 {
        let n = nums1.len();
        let mut freq = HashMap::new();
        let mut total_swaps = 0;
        let mut max_freq = 0;
        let mut max_num = 0;
        let mut cost = 0;

        for i in 0..n {
            if nums1[i] == nums2[i] {
                *freq.entry(nums1[i]).or_insert(0) += 1;
                total_swaps += 1;
                cost += i as i64;
                if *freq.get(&nums1[i]).unwrap() > max_freq {
                    max_freq = *freq.get(&nums1[i]).unwrap();
                    max_num = nums1[i];
                }
            }
        }

        if max_freq * 2 <= total_swaps {
            return cost;
        }

        let mut extra_needed = 2 * max_freq - total_swaps;
        for i in 0..n {
            if extra_needed <= 0 {
                break;
            }
            if nums1[i] != nums2[i] && nums1[i] != max_num && nums2[i] != max_num {
                cost += i as i64;
                extra_needed -= 1;
            }
        }

        if extra_needed > 0 {
            return -1;
        }

        cost
    }
}