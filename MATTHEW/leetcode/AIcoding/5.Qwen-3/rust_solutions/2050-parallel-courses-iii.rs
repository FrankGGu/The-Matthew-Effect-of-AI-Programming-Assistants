impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn min_days(&self, n: i32) -> i32 {
        let mut memo = HashMap::new();
        Self::dfs(n, &mut memo)
    }

    fn dfs(x: i32, memo: &mut HashMap<i32, i32>) -> i32 {
        if x <= 1 {
            return x;
        }
        if let Some(&res) = memo.get(&x) {
            return res;
        }
        let res = 1 + std::cmp::min(Self::dfs(x / 2, memo), Self::dfs(x / 3, memo));
        memo.insert(x, res);
        res
    }
}
}