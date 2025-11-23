impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_days(n: i32) -> i32 {
        let mut dp = std::collections::HashMap::new();
        dp.insert(0, 0);
        Self::dfs(n, &mut dp)
    }

    fn dfs(x: i32, dp: &mut std::collections::HashMap<i32, i32>) -> i32 {
        if let Some(&res) = dp.get(&x) {
            return res;
        }
        let res = 1 + std::cmp::min(Self::dfs(x / 2, dp), Self::dfs(x / 3, dp));
        dp.insert(x, res);
        res
    }
}
}