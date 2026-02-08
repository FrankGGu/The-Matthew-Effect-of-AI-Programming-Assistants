use std::collections::HashMap;

struct Solution;

impl Solution {
    fn solve(n: i32, memo: &mut HashMap<i32, i32>) -> i32 {
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return 1;
        }
        if let Some(&res) = memo.get(&n) {
            return res;
        }

        let result;
        if n % 2 == 0 {
            result = Self::solve(n / 2, memo);
        } else {
            let ops_minus_one = 1 + Self::solve((n - 1) / 2, memo);
            let ops_plus_one = 1 + Self::solve((n + 1) / 2, memo);
            result = ops_minus_one.min(ops_plus_one);
        }

        memo.insert(n, result);
        result
    }

    pub fn min_operations(n: i32) -> i32 {
        let mut memo = HashMap::new();
        Self::solve(n, &mut memo)
    }
}