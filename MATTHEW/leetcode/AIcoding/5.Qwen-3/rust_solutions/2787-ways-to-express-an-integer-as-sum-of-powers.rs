impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn pow_sum(n: i32) -> i32 {
        let mut memo = HashMap::new();
        Self::dfs(n, 2, &mut memo)
    }

    fn dfs(n: i32, start: i32, memo: &mut HashMap<(i32, i32), i32>) -> i32 {
        if n == 0 {
            return 1;
        }
        if n < 0 {
            return 0;
        }
        let key = (n, start);
        if let Some(&count) = memo.get(&key) {
            return count;
        }

        let mut count = 0;
        let mut power = start.pow(2);
        while power <= n {
            count += Self::dfs(n - power, start + 1, memo);
            start += 1;
            power = start.pow(2);
        }

        memo.insert(key, count);
        count
    }
}
}