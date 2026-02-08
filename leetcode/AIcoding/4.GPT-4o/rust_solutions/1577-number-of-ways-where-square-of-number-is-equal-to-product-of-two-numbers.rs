impl Solution {
    pub fn num_triplets(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        fn count_triplets(nums: &[i32], target: i32) -> i32 {
            let mut count = 0;
            let mut freq = std::collections::HashMap::new();
            for &num in nums {
                *freq.entry(num).or_insert(0) += 1;
            }
            for &num in nums {
                if target % num == 0 {
                    let complement = target / num;
                    count += freq.get(&complement).unwrap_or(&0);
                    if complement == num {
                        count -= 1;
                    }
                }
            }
            count / 2
        }

        let mut total = 0;
        for &num in &nums1 {
            total += count_triplets(&nums2, num * num);
        }
        for &num in &nums2 {
            total += count_triplets(&nums1, num * num);
        }
        total
    }
}