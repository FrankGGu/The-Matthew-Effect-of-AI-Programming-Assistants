impl Solution {
    pub fn can_i_win(max_choosable_integer: i32, desired_total: i32) -> bool {
        if max_choosable_integer >= desired_total {
            return true;
        }
        if (max_choosable_integer * (max_choosable_integer + 1)) / 2 < desired_total {
            return false;
        }

        let mut memo = std::collections::HashMap::new();
        Self::dfs(0, max_choosable_integer, desired_total, &mut memo)
    }

    fn dfs(state: i32, max: i32, total: i32, memo: &mut std::collections::HashMap<i32, bool>) -> bool {
        if let Some(&res) = memo.get(&state) {
            return res;
        }

        for i in 1..=max {
            let mask = 1 << (i - 1);
            if (state & mask) == 0 {
                if i >= total || !Self::dfs(state | mask, max, total - i, memo) {
                    memo.insert(state, true);
                    return true;
                }
            }
        }

        memo.insert(state, false);
        false
    }
}