impl Solution {
    pub fn ways_to_reach_stair(k: i32) -> i32 {
        let mut memo = std::collections::HashMap::new();
        Self::dfs(1, 0, 0, k, &mut memo)
    }

    fn dfs(pos: i32, jump: i32, prev_move: i32, k: i32, memo: &mut std::collections::HashMap<(i32, i32, i32), i32>) -> i32 {
        if pos == k {
            return 1;
        }
        if pos < 0 || pos > k + 1 {
            return 0;
        }
        if let Some(&res) = memo.get(&(pos, jump, prev_move)) {
            return res;
        }

        let mut res = 0;
        if prev_move != 1 {
            res += Self::dfs(pos - 1, jump, 1, k, memo);
        }
        res += Self::dfs(pos + (1 << jump), jump + 1, 0, k, memo);

        memo.insert((pos, jump, prev_move), res);
        res
    }
}