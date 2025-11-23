impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_cost_to_merge_stones(piles: Vec<i32>, k: i32) -> i32 {
        let n = piles.len();
        let k = k as usize;
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + piles[i];
        }

        let mut dp = vec![vec![0; n]; n];
        let mut memo = std::collections::HashMap::new();

        fn dfs(i: usize, j: usize, k: usize, prefix: &[i32], dp: &mut Vec<Vec<i32>>, memo: &mut std::collections::HashMap<(usize, usize, usize), i32>) -> i32 {
            if i == j {
                return 0;
            }
            if let Some(&res) = memo.get(&(i, j, k)) {
                return res;
            }
            let mut res = i32::MAX;
            if (j - i) % (k - 1) == 0 {
                let cost = prefix[j + 1] - prefix[i];
                for m in (i..j).step_by(k - 1) {
                    res = res.min(dfs(i, m, k, prefix, dp, memo) + dfs(m + 1, j, k, prefix, dp, memo));
                }
                res += cost;
            } else {
                for m in i..j {
                    res = res.min(dfs(i, m, k, prefix, dp, memo) + dfs(m + 1, j, k, prefix, dp, memo));
                }
            }
            memo.insert((i, j, k), res);
            res
        }

        dfs(0, n - 1, k, &prefix, &mut dp, &mut memo)
    }
}
}