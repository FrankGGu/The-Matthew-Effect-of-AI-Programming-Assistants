use std::collections::HashSet;

impl Solution {
    pub fn max_partitions_after_operations(s: String, k: i32) -> i32 {
        let s = s.chars().collect::<Vec<_>>();
        let n = s.len();
        let k = k as usize;
        let mut memo = vec![vec![vec![-1; 26]; k + 1]; n];

        fn dp(i: usize, mask: usize, changed: bool, s: &[char], k: usize, memo: &mut Vec<Vec<Vec<i32>>>) -> i32 {
            if i == s.len() {
                return 1;
            }
            let c = s[i] as usize - 'a' as usize;
            let key = if changed { 26 } else { c };
            if memo[i][mask][key] != -1 {
                return memo[i][mask][key];
            }
            let mut res = 0;
            let new_mask = mask | (1 << c);
            if new_mask.count_ones() as usize > k {
                res = 1 + dp(i + 1, 1 << c, changed, s, k, memo);
            } else {
                res = dp(i + 1, new_mask, changed, s, k, memo);
            }
            if !changed {
                for new_c in 0..26 {
                    if new_c == c {
                        continue;
                    }
                    let new_mask = mask | (1 << new_c);
                    let temp = if new_mask.count_ones() as usize > k {
                        1 + dp(i + 1, 1 << new_c, true, s, k, memo)
                    } else {
                        dp(i + 1, new_mask, true, s, k, memo)
                    };
                    res = res.max(temp);
                }
            }
            memo[i][mask][key] = res;
            res
        }

        dp(0, 0, false, &s, k, &mut memo)
    }
}