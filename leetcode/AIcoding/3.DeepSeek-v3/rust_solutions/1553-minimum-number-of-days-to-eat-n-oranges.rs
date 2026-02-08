use std::collections::HashMap;

impl Solution {
    pub fn min_days(n: i32) -> i32 {
        let mut memo = HashMap::new();
        Self::dfs(n, &mut memo)
    }

    fn dfs(n: i32, memo: &mut HashMap<i32, i32>) -> i32 {
        if n <= 1 {
            return n;
        }
        if let Some(&res) = memo.get(&n) {
            return res;
        }
        let res = 1 + std::cmp::min(
            n % 2 + Self::dfs(n / 2, memo),
            n % 3 + Self::dfs(n / 3, memo),
        );
        memo.insert(n, res);
        res
    }
}