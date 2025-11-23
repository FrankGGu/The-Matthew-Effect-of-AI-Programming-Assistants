use std::collections::HashMap;

impl Solution {
    pub fn find_the_number_of_copy_arrays(nums1: Vec<i32>, nums2: Vec<i32>) -> i64 {
        let mut freq_nums1: HashMap<i32, i32> = HashMap::new();

        for &num in nums1.iter() {
            *freq_nums1.entry(num).or_insert(0) += 1;
        }

        let mut count: i64 = 0;
        for &num in nums2.iter() {
            if let Some(&freq) = freq_nums1.get(&num) {
                count += freq as i64;
            }
        }

        count
    }
}