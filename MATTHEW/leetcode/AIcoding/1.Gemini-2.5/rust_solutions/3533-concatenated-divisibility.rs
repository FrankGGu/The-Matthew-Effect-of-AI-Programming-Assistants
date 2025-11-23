use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn concatenated_divisibility(nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        if n == 0 {
            return false;
        }
        if k == 1 {
            return true;
        }

        let k_usize = k as usize;

        let mut num_lens = vec![0; n];
        let mut pow10_mod_k = vec![0; n];

        for i in 0..n {
            let num = nums[i];
            let mut len = 0;
            if num == 0 {
                len = 1;
            } else {
                let mut temp = num;
                while temp > 0 {
                    temp /= 10;
                    len += 1;
                }
            }
            num_lens[i] = len;

            let mut p = 1;
            for _ in 0..len {
                p = (p * 10) % k;
            }
            pow10_mod_k[i] = p;
        }

        let mut memo: Vec<Vec<Option<bool>>> = vec![vec![None; k_usize]; 1 << n];

        fn dfs(
            mask: usize,
            current_remainder: i32,
            n: usize,
            k: i32,
            nums: &[i32],
            pow10_mod_k: &[i32],
            memo: &mut Vec<Vec<Option<bool>>>,
        ) -> bool {
            if mask == (1 << n) - 1 {
                return current_remainder == 0;
            }

            if let Some(res) = memo[mask][current_remainder as usize] {
                return res;
            }

            for i in 0..n {
                if (mask >> i) & 1 == 0 {
                    let num_val = nums[i];
                    let p10 = pow10_mod_k[i];

                    let new_remainder = (current_remainder as i64 * p10 as i64 + num_val as i64) % k as i64;
                    let new_remainder_i32 = new_remainder as i32;

                    if dfs(mask | (1 << i), new_remainder_i32, n, k, nums, pow10_mod_k, memo) {
                        memo[mask][current_remainder as usize] = Some(true);
                        return true;
                    }
                }
            }

            memo[mask][current_remainder as usize] = Some(false);
            false
        }

        dfs(0, 0, n, k, &nums, &pow10_mod_k, &mut memo)
    }
}