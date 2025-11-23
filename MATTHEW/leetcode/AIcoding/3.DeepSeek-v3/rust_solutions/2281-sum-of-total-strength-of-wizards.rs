use std::collections::VecDeque;

const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn total_strength(strength: Vec<i32>) -> i32 {
        let n = strength.len();
        let mut left = vec![-1; n];
        let mut right = vec![n as i64; n];
        let mut stack = VecDeque::new();

        for i in 0..n {
            while !stack.is_empty() && strength[*stack.back().unwrap()] >= strength[i] {
                stack.pop_back();
            }
            if !stack.is_empty() {
                left[i] = *stack.back().unwrap() as i64;
            }
            stack.push_back(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while !stack.is_empty() && strength[*stack.back().unwrap()] > strength[i] {
                stack.pop_back();
            }
            if !stack.is_empty() {
                right[i] = *stack.back().unwrap() as i64;
            }
            stack.push_back(i);
        }

        let mut prefix = vec![0; n + 2];
        for i in 0..n {
            prefix[i + 1] = (prefix[i] + strength[i] as i64) % MOD;
        }

        let mut prefix_prefix = vec![0; n + 2];
        for i in 0..=n {
            prefix_prefix[i + 1] = (prefix_prefix[i] + prefix[i]) % MOD;
        }

        let mut res = 0;
        for i in 0..n {
            let l = left[i] + 1;
            let r = right[i] - 1;
            let total = (strength[i] as i64) * 
                ((prefix_prefix[r as usize + 2] - prefix_prefix[i + 1] + MOD) % MOD * (i as i64 - l + 1) % MOD - 
                (prefix_prefix[i + 1] - prefix_prefix[l as usize] + MOD) % MOD * (r - i as i64 + 1) % MOD + MOD) % MOD;
            res = (res + total) % MOD;
        }

        res as i32
    }
}