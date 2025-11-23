impl Solution {
    pub fn minimum_incompatibility(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let group_size = n / k as usize;

        let mut count = std::collections::HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
            if count[&num] > 1 {
                return -1;
            }
        }

        let mut masks = Vec::new();
        for i in 0..(1 << n) {
            if i.count_ones() != group_size as u32 {
                continue;
            }

            let mut seen = std::collections::HashSet::new();
            let mut valid = true;
            let mut sum = 0;
            let mut min_val = 1001;
            let mut max_val = 0;

            for j in 0..n {
                if (i >> j) & 1 != 0 {
                    if seen.contains(&nums[j]) {
                        valid = false;
                        break;
                    }
                    seen.insert(nums[j]);
                    sum += nums[j];
                    min_val = min_val.min(nums[j]);
                    max_val = max_val.max(nums[j]);
                }
            }

            if valid {
                masks.push((i, max_val - min_val));
            }
        }

        let mut dp = vec![std::i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            if dp[mask] == std::i32::MAX {
                continue;
            }

            for &(submask, diff) in &masks {
                if mask & submask == 0 {
                    let new_mask = mask | submask;
                    dp[new_mask] = dp[new_mask].min(dp[mask] + diff);
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