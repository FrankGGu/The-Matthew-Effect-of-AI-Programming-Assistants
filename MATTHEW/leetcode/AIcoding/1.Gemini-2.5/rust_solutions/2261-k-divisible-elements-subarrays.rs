use std::collections::HashSet;

impl Solution {
    pub fn count_distinct_subarrays(nums: Vec<i32>, k: i32, p: i32) -> i32 {
        let n = nums.len();
        let mut distinct_subarrays: HashSet<Vec<i32>> = HashSet::new();

        for i in 0..n {
            let mut current_divisible_count = 0;
            for j in i..n {
                if nums[j] % p == 0 {
                    current_divisible_count += 1;
                }

                if current_divisible_count <= k {
                    distinct_subarrays.insert(nums[i..=j].to_vec());
                } else {
                    // If current_divisible_count exceeds k,
                    // any further subarray starting at i and extending beyond j
                    // will also exceed k. So, we can break from the inner loop.
                    break;
                }
            }
        }

        distinct_subarrays.len() as i32
    }
}