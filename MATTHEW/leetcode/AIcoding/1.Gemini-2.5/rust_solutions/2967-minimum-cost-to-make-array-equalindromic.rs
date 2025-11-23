impl Solution {
    fn calculate_cost(nums: &[i32], p: i64) -> i64 {
        nums.iter().map(|&x| (x as i64 - p).abs()).sum()
    }

    fn generate_palindromes(max_val: i64) -> Vec<i64> {
        let mut palindromes = Vec::new();
        let max_val_str_len = max_val.to_string().len();

        let mut base = 1;
        loop {
            let s_base = base.to_string();
            let reversed_s_base: String = s_base.chars().rev().collect();

            // Odd length palindromes (e.g., base = 123 -> 12321)
            let mut p_str_odd = s_base.clone();
            if s_base.len() > 0 {
                p_str_odd.push_str(&reversed_s_base[1..]);
            }
            if let Ok(p_odd) = p_str_odd.parse::<i64>() {
                if p_odd <= max_val {
                    palindromes.push(p_odd);
                }
            }

            // Even length palindromes (e.g., base = 12 -> 1221)
            let mut p_str_even = s_base.clone();
            p_str_even.push_str(&reversed_s_base);
            if let Ok(p_even) = p_str_even.parse::<i64>() {
                if p_even <= max_val {
                    palindromes.push(p_even);
                }
            }

            // Stopping condition: if the smallest possible palindrome from `base`
            // (which is an odd-length palindrome if `base` has > 0 digits)
            // would have a string representation length exceeding `max_val_str_len + 1`,
            // then we can safely stop.
            // `s_base.len() * 2 - 1` is the length of the odd palindrome.
            if s_base.len() * 2 - 1 > max_val_str_len + 1 {
                break;
            }
            base += 1;
        }

        palindromes.sort_unstable();
        palindromes.dedup();
        palindromes
    }

    pub fn minimum_cost(mut nums: Vec<i32>) -> i64 {
        nums.sort_unstable();
        let n = nums.len();
        let median_val = nums[n / 2] as i64;

        // Generate palindromes up to a safe upper bound.
        // Max nums[i] is 10^9. The optimal palindrome might be slightly larger.
        // 2 * 10^9 covers all 9-digit palindromes and some 10-digit ones.
        let all_palindromes = Self::generate_palindromes(2_000_000_000);

        let mut min_cost = i64::MAX;

        // Find the insertion point for `median_val` in the sorted list of palindromes.
        // This gives us an index `search_idx` such that `all_palindromes[search_idx]`
        // is the smallest palindrome >= `median_val`, or `search_idx` is `all_palindromes.len()`.
        let search_idx = all_palindromes.binary_search(&median_val).unwrap_or_else(|e| e);

        // Check a small window of palindromes around the `median_val`.
        // The cost function is convex, so the minimum will be at a palindrome
        // numerically close to the median of `nums`.
        // A window of 10 palindromes before and 10 palindromes after the search_idx
        // should be sufficient to find the optimal one.
        let start_idx = search_idx.saturating_sub(10);
        let end_idx = (search_idx + 10).min(all_palindromes.len());

        for i in start_idx..end_idx {
            let p = all_palindromes[i];
            let current_cost = Self::calculate_cost(&nums, p);
            min_cost = min_cost.min(current_cost);
        }

        min_cost
    }
}