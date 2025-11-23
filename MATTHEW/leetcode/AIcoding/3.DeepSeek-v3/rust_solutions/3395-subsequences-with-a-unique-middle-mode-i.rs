use std::collections::HashMap;

impl Solution {
    pub fn number_of_good_subsequences(nums: Vec<i32>) -> i32 {
        let mod_num = 1_000_000_007;
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }
        let mut max_freq = 0;
        for &cnt in freq.values() {
            if cnt > max_freq {
                max_freq = cnt;
            }
        }
        let mut result = 0;
        for m in 1..=max_freq {
            let mut ways = 1;
            for (&num, &cnt) in &freq {
                if cnt >= m {
                    ways = (ways * (cnt - m + 1)) % mod_num;
                }
            }
            result = (result + ways) % mod_num;
        }
        result
    }
}