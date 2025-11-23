impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

impl Solution {
    pub fn num_ways(nums: Vec<i32>) -> i32 {
        fn comb(n: usize, k: usize, fact: &[usize], inv_fact: &[usize]) -> usize {
            if k > n || k < 0 {
                return 0;
            }
            fact[n] * inv_fact[k] % 1_000_000_007 * inv_fact[n - k] % 1_000_000_007
        }

        fn dfs(nums: &[i32], fact: &[usize], inv_fact: &[usize]) -> usize {
            if nums.len() <= 1 {
                return 1;
            }

            let root = nums[0];
            let mut left = Vec::new();
            let mut right = Vec::new();

            for &num in nums.iter().skip(1) {
                if num < root {
                    left.push(num);
                } else {
                    right.push(num);
                }
            }

            let left_ways = dfs(&left, fact, inv_fact);
            let right_ways = dfs(&right, fact, inv_fact);

            let n = left.len() + right.len();
            let k = left.len();

            (comb(n, k, fact, inv_fact) as usize * left_ways % 1_000_000_007 * right_ways % 1_000_000_007) as usize
        }

        const MOD: usize = 1_000_000_007;
        let max_n = nums.len();
        let mut fact = vec![1; max_n + 1];
        let mut inv_fact = vec![1; max_n + 1];

        for i in 1..=max_n {
            fact[i] = fact[i - 1] * i % MOD;
        }

        inv_fact[max_n] = pow(fact[max_n], MOD - 2, MOD);
        for i in (0..max_n).rev() {
            inv_fact[i] = inv_fact[i + 1] * (i + 1) % MOD;
        }

        dfs(&nums, &fact, &inv_fact) as i32
    }

    fn pow(mut a: usize, mut b: usize, mod_val: usize) -> usize {
        let mut result = 1;
        while b > 0 {
            if b % 2 == 1 {
                result = result * a % mod_val;
            }
            a = a * a % mod_val;
            b /= 2;
        }
        result
    }
}
}