use std::collections::HashMap;

impl Solution {
    pub fn count_sub_multisets(nums: Vec<i32>, l: i32, r: i32) -> i32 {
        let mod_num = 1_000_000_007;
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }
        let max_sum = r as usize;
        let mut dp = vec![0; max_sum + 1];
        dp[0] = 1;
        for (&num, &cnt) in freq.iter() {
            let num = num as usize;
            for s in (0..=max_sum).rev() {
                if dp[s] == 0 {
                    continue;
                }
                for k in 1..=cnt {
                    let next_s = s + k * num;
                    if next_s > max_sum {
                        break;
                    }
                    dp[next_s] = (dp[next_s] + dp[s]) % mod_num;
                }
            }
        }
        let mut res = 0;
        for s in l..=r {
            if s as usize <= max_sum {
                res = (res + dp[s as usize]) % mod_num;
            }
        }
        res
    }
}