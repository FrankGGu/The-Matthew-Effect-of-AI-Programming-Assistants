impl Solution {
    pub fn minimum_incompatibility(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let group_size = n / k as usize;
        let mut freq = std::collections::HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
            if freq[&num] > 1 {
                return -1;
            }
        }

        let mut masks = Vec::new();
        for i in 0..n {
            masks.push(1 << i);
        }

        let mut valid_subsets = Vec::new();
        for mask in 0..(1 << n) {
            if mask.count_ones() != group_size as u32 {
                continue;
            }

            let mut subset = Vec::new();
            for i in 0..n {
                if (mask & (1 << i)) != 0 {
                    subset.push(nums[i]);
                }
            }

            let mut set = std::collections::HashSet::new();
            let mut is_valid = true;
            for &num in &subset {
                if !set.insert(num) {
                    is_valid = false;
                    break;
                }
            }

            if is_valid {
                let min_val = *subset.iter().min().unwrap();
                let max_val = *subset.iter().max().unwrap();
                valid_subsets.push((mask, max_val - min_val));
            }
        }

        let mut dp = vec![std::i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            if dp[mask] == std::i32::MAX {
                continue;
            }

            for &(subset_mask, incompatibility) in &valid_subsets {
                if (mask & subset_mask) == 0 {
                    let new_mask = mask | subset_mask;
                    dp[new_mask] = dp[new_mask].min(dp[mask] + incompatibility);
                }
            }
        }

        if dp[(1 << n) - 1] == std::i32::MAX {
            -1
        } else {
            dp[(1 << n) - 1]
        }
    }
}