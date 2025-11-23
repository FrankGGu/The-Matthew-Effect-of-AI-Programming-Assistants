impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn unique_paths(m: i32, n: i32) -> i32 {
        let mut memo = HashMap::new();
        Self::dp(m, n, &mut memo)
    }

    fn dp(m: i32, n: i32, memo: &mut HashMap<(i32, i32), i32>) -> i32 {
        if m == 1 || n == 1 {
            return 1;
        }
        if let Some(&val) = memo.get(&(m, n)) {
            return val;
        }
        let result = Self::dp(m - 1, n, memo) + Self::dp(m, n - 1, memo);
        memo.insert((m, n), result);
        result
    }
}
}