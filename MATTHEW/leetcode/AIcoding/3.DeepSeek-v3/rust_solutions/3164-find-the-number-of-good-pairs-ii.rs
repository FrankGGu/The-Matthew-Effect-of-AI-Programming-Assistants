use std::collections::HashMap;

impl Solution {
    pub fn number_of_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        let mut freq = HashMap::new();
        for &num in nums2.iter() {
            *freq.entry(num * k).or_insert(0) += 1;
        }

        let mut res = 0;
        for &num in nums1.iter() {
            let mut i = 1;
            while i * i <= num {
                if num % i == 0 {
                    if let Some(&count) = freq.get(&i) {
                        res += count as i64;
                    }
                    let j = num / i;
                    if j != i {
                        if let Some(&count) = freq.get(&j) {
                            res += count as i64;
                        }
                    }
                }
                i += 1;
            }
        }
        res
    }
}