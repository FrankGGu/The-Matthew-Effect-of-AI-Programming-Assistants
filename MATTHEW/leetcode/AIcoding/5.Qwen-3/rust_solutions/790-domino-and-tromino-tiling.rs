impl Solution {

mod solution {
    use std::collections::HashMap;

    pub fn num_tilings(n: i32) -> i32 {
        let mut memo = HashMap::new();
        dfs(n, &mut memo)
    }

    fn dfs(n: i32, memo: &mut HashMap<i32, i32>) -> i32 {
        if n < 0 {
            return 0;
        }
        if n == 0 {
            return 1;
        }
        if let Some(&res) = memo.get(&n) {
            return res;
        }

        let res = (dfs(n - 1, memo) + dfs(n - 2, memo) + 2 * dfs(n - 3, memo)) % 1000000007;
        memo.insert(n, res);
        res
    }
}
}