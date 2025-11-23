impl Solution {
    pub fn last_stone_weight(stones: Vec<i32>) -> i32 {
        let mut stones = stones;
        stones.sort_unstable_by(|a, b| b.cmp(a));

        while stones.len() > 1 {
            let first = stones.remove(0);
            let second = stones.remove(0);
            if first != second {
                stones.push(first - second);
                stones.sort_unstable_by(|a, b| b.cmp(a));
            }
        }

        stones.get(0).cloned().unwrap_or(0)
    }
}