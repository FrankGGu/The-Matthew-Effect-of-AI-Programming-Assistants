use std::collections::HashSet;

impl Solution {
    pub fn can_cross(stones: Vec<i32>) -> bool {
        let n = stones.len();
        let mut dp: std::collections::HashMap<i32, HashSet<i32>> = std::collections::HashMap::new();
        dp.insert(0, HashSet::from([0]));

        for i in 0..n {
            let stone = stones[i];
            if !dp.contains_key(&stone) {
                continue;
            }
            let jumps = dp.get(&stone).unwrap().clone();
            for jump in jumps {
                for next_jump in [jump - 1, jump, jump + 1] {
                    if next_jump > 0 {
                        let next_stone = stone + next_jump;
                        if stones.contains(&next_stone) {
                            dp.entry(next_stone).or_insert(HashSet::new()).insert(next_jump);
                        }
                    }
                }
            }
        }

        dp.contains_key(&stones[n - 1])
    }
}