use std::cmp::BinaryHeap;

pub fn min_absolute_sum_diff(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
    let mut total_diff = 0;
    let mut max_gain = 0;
    let mod_val = 1_000_000_007;

    let mut sorted_nums1 = nums1.clone();
    sorted_nums1.sort();

    for (n1, n2) in nums1.iter().zip(nums2.iter()) {
        let diff = (n1 - n2).abs();
        total_diff = (total_diff + diff) % mod_val;

        if let Ok(pos) = sorted_nums1.binary_search(n2) {
            let new_diff = (n1 - sorted_nums1[pos]).abs();
            max_gain = max_gain.max(diff - new_diff);
        }

        if let Some(pos) = sorted_nums1.iter().position(|&x| x > *n2) {
            let new_diff = (n1 - sorted_nums1[pos - 1]).abs();
            max_gain = max_gain.max(diff - new_diff);
        }
    }

    (total_diff - max_gain + mod_val) % mod_val
}