impl Solution {
    pub fn least_ops_express_target(x: i32, target: i32) -> i32 {
        fn dfs(x: i32, target: i32) -> (i32, i32) {
            if target == 0 {
                return (0, 1);
            }
            if target == 1 {
                return (1, 1);
            }
            let mut n = 0;
            let mut temp = target;
            while temp > 0 {
                temp /= x;
                n += 1;
            }
            let max_pow = x.pow(n - 1);
            let min_ops = dfs(x, target - max_pow);
            let add_ops = if min_ops.1 == 1 { 1 } else { 0 };
            let min_ops = min_ops.0 + add_ops + 1;
            let min_ops2 = dfs(x, max_pow - target);
            let min_ops2 = if min_ops2.1 == 1 { 1 } else { 0 };
            let min_ops2 = min_ops2.0 + min_ops2 + 1;
            (min_ops.min(min_ops2), 0)
        }
        let (ops, _) = dfs(x, target);
        ops
    }
}