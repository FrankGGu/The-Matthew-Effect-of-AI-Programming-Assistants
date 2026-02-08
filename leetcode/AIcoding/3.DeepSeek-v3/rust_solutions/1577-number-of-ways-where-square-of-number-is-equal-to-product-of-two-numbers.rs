use std::collections::HashMap;

impl Solution {
    pub fn num_triplets(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut count = 0;
        count += Self::count_triplets(&nums1, &nums2);
        count += Self::count_triplets(&nums2, &nums1);
        count
    }

    fn count_triplets(nums1: &Vec<i32>, nums2: &Vec<i32>) -> i32 {
        let mut count = 0;
        let mut freq = HashMap::new();
        for &num in nums1 {
            let square = num as i64 * num as i64;
            freq.clear();
            for &other in nums2 {
                if square % other as i64 == 0 {
                    let target = (square / other as i64) as i32;
                    count += freq.get(&target).unwrap_or(&0);
                }
                *freq.entry(other).or_insert(0) += 1;
            }
        }
        count
    }
}