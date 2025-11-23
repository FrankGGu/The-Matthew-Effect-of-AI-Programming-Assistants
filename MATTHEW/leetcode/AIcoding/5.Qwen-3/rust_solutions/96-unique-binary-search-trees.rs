impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn num_trees(n: i32) -> i32 {
        let mut memo = HashMap::new();
        Self::count(n, &mut memo)
    }

    fn count(n: i32, memo: &mut HashMap<i32, i32>) -> i32 {
        if n == 0 || n == 1 {
            return 1;
        }
        if let Some(&val) = memo.get(&n) {
            return val;
        }
        let mut total = 0;
        for i in 1..=n {
            total += Self::count(i - 1, memo) * Self::count(n - i, memo);
        }
        memo.insert(n, total);
        total
    }
}
}