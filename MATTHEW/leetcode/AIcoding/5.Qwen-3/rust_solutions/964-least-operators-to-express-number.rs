impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn least_ops_to_express(x: i32, target: i32) -> i32 {
        fn dfs(x: i32, target: i32, memo: &mut HashMap<(i32, i32), i32>) -> i32 {
            if target == 0 {
                return 0;
            }
            if target == 1 {
                return 1;
            }
            if let Some(&res) = memo.get(&(x, target)) {
                return res;
            }

            let mut res = i32::MAX;
            let mut k = 0;
            let mut curr = 1;
            while curr < target {
                curr *= x;
                k += 1;
            }

            // Use current power
            if curr == target {
                res = res.min(k);
            } else {
                // Use subtract
                res = res.min(dfs(x, target - curr / x, memo) + k);
                // Use add
                res = res.min(dfs(x, target - curr, memo) + k + 1);
            }

            // Use previous power
            if curr / x != 0 {
                res = res.min(dfs(x, target - curr / x, memo) + k - 1);
            }

            memo.insert((x, target), res);
            res
        }

        dfs(x, target, &mut HashMap::new())
    }
}
}