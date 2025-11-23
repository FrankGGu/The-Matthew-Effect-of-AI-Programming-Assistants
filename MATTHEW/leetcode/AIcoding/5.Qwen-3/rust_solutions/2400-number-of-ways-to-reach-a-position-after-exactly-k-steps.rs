impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_ways(position: i32, k: i32) -> i32 {
        let mut memo = HashMap::new();
        dfs(0, position, k, &mut memo)
    }
}

fn dfs(current: i32, target: i32, steps_left: i32, memo: &mut HashMap<(i32, i32), i32>) -> i32 {
    if steps_left == 0 {
        return if current == target { 1 } else { 0 };
    }

    let key = (current, steps_left);
    if let Some(&result) = memo.get(&key) {
        return result;
    }

    let mut ways = 0;
    if current > -100 {
        ways += dfs(current - 1, target, steps_left - 1, memo);
    }
    if current < 100 {
        ways += dfs(current + 1, target, steps_left - 1, memo);
    }

    memo.insert(key, ways);
    ways
}
}