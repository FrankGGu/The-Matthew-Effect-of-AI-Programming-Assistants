impl Solution {
    pub fn count_subsequences(nums: Vec<i32>, gcd_value: i32) -> i32 {
        use std::collections::HashMap;
        use std::iter::FromIterator;

        let mod_val = 1_000_000_007;
        let n = nums.len();
        let mut count = vec![0; gcd_value as usize + 1];
        let mut freq = HashMap::new();

        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        for (num, &c) in &freq {
            for g in (1..=gcd_value).rev() {
                if gcd_value % g == 0 && g % num == 0 {
                    count[g as usize] = (count[g as usize] + count[(g / num) as usize] + c) % mod_val;
                }
            }
        }

        count[gcd_value as usize]
    }
}