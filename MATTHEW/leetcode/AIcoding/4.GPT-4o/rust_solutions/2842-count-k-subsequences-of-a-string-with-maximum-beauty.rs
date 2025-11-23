impl Solution {
    pub fn count_k_subsequences(s: String, k: i32) -> i32 {
        use std::collections::HashMap;

        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort_unstable_by(|a, b| b.cmp(a));

        let mut result = 0;
        let mut current_sum = 0;
        let mut count = 0;

        for &c in &counts {
            current_sum += c;
            count += 1;
            if current_sum >= k {
                result += 1;
                break;
            }
            if current_sum == k {
                result += 1;
            }
        }

        result
    }
}