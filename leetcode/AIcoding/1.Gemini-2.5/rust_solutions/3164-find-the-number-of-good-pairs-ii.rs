use std::collections::HashMap;

impl Solution {
    pub fn number_of_good_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        let mut freq_map2: HashMap<i32, i32> = HashMap::new();

        for &num in &nums2 {
            *freq_map2.entry(num).or_insert(0) += 1;
        }

        let mut good_pairs_count: i64 = 0;

        for &num1 in &nums1 {
            if num1 % k == 0 {
                let target = num1 / k;
                if let Some(&count) = freq_map2.get(&target) {
                    good_pairs_count += count as i64;
                }
            }
        }

        good_pairs_count
    }
}