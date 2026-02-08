use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn minimum_incompatibility(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        if n % k != 0 {
            return -1;
        }
        let m = n / k;
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
            if *freq.get(&num).unwrap() > k {
                return -1;
            }
        }
        let mut dp = vec![-1; 1 << n];
        dp[0] = 0;
        for mask in 0..1 << n {
            if dp[mask] == -1 {
                continue;
            }
            let mut available = Vec::new();
            for i in 0..n {
                if mask & (1 << i) == 0 {
                    available.push(i);
                }
            }
            if available.len() < m {
                continue;
            }
            let mut combinations = Vec::new();
            Self::generate_combinations(&available, m, 0, &mut Vec::new(), &mut combinations);
            for comb in combinations {
                let mut subset = Vec::new();
                let mut new_mask = mask;
                for &i in &comb {
                    subset.push(nums[i]);
                    new_mask |= 1 << i;
                }
                let mut unique = HashSet::new();
                let mut valid = true;
                for &num in &subset {
                    if unique.contains(&num) {
                        valid = false;
                        break;
                    }
                    unique.insert(num);
                }
                if !valid {
                    continue;
                }
                let min_val = *subset.iter().min().unwrap();
                let max_val = *subset.iter().max().unwrap();
                let diff = max_val - min_val;
                if dp[new_mask] == -1 || dp[new_mask] > dp[mask] + diff {
                    dp[new_mask] = dp[mask] + diff;
                }
            }
        }
        dp[(1 << n) - 1]
    }

    fn generate_combinations(
        available: &[usize],
        m: usize,
        start: usize,
        current: &mut Vec<usize>,
        result: &mut Vec<Vec<usize>>,
    ) {
        if current.len() == m {
            result.push(current.clone());
            return;
        }
        for i in start..available.len() {
            current.push(available[i]);
            Self::generate_combinations(available, m, i + 1, current, result);
            current.pop();
        }
    }
}