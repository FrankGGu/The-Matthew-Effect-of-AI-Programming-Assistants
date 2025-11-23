use std::collections::HashMap;
use std::collections::HashSet;

impl Solution {
    pub fn find_the_median_of_the_uniqueness_array(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        // Coordinate compression
        let mut distinct_nums_set: HashSet<i32> = nums.iter().cloned().collect();
        let mut distinct_nums_vec: Vec<i32> = distinct_nums_set.into_iter().collect();
        distinct_nums_vec.sort_unstable();

        let mut val_to_compressed_id: HashMap<i32, usize> = HashMap::new();
        for (i, &val) in distinct_nums_vec.iter().enumerate() {
            val_to_compressed_id.insert(val, i);
        }

        let mut compressed_nums: Vec<usize> = Vec::with_capacity(n);
        for &val in nums.iter() {
            compressed_nums.push(*val_to_compressed_id.get(&val).unwrap());
        }

        let total_subarrays = n as i64 * (n as i64 + 1) / 2;
        let target_count = (total_subarrays + 1) / 2;

        let mut low = 1;
        let mut high = n as i32;
        let mut ans = n as i32;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::count_subarrays_with_at_most_k_unique(mid, n, &compressed_nums) >= target_count {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        ans
    }

    fn count_subarrays_with_at_most_k_unique(max_unique_allowed: i32, n: usize, compressed_nums: &[usize]) -> i64 {
        let mut count_valid_subarrays = 0;
        let mut left = 0;
        let mut current_unique_count = 0;
        let mut freq = vec![0; n]; 

        for right in 0..n {
            let val_compressed = compressed_nums[right];
            if freq[val_compressed] == 0 {
                current_unique_count += 1;
            }
            freq[val_compressed] += 1;

            while current_unique_count > max_unique_allowed {
                let val_to_remove_compressed = compressed_nums[left];
                freq[val_to_remove_compressed] -= 1;
                if freq[val_to_remove_compressed] == 0 {
                    current_unique_count -= 1;
                }
                left += 1;
            }

            count_valid_subarrays += (right - left + 1) as i64;
        }
        count_valid_subarrays
    }
}