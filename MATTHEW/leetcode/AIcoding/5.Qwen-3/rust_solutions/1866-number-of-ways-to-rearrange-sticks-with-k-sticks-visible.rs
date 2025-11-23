impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn rearrange_sticks(n: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        let mut memo = HashMap::new();

        fn dfs(n: usize, k: usize, dp: &mut Vec<Vec<i32>>, memo: &mut HashMap<(usize, usize), i32>) -> i32 {
            if k == 0 {
                return 1;
            }
            if n == 0 {
                return 0;
            }
            if let Some(&res) = memo.get(&(n, k)) {
                return res;
            }
            let mut res = 0;
            for i in 1..=n {
                if k > 0 {
                    res += dfs(n - i, k - 1, dp, memo);
                    res %= MOD;
                }
            }
            memo.insert((n, k), res);
            res
        }

        dfs(n, k, &mut dp, &mut memo)
    }
}
}