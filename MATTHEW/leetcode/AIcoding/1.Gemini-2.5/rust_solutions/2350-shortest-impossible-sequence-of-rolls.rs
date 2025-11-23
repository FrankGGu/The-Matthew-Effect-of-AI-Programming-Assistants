use std::collections::HashSet;

impl Solution {
    pub fn shortest_impossible_sequence(rolls: Vec<i32>, k: i32) -> i32 {
        let mut ans = 1;
        let mut seen: HashSet<i32> = HashSet::new();

        for roll in rolls {
            if roll >= 1 && roll <= k {
                seen.insert(roll);
            }

            if seen.len() == k as usize {
                ans += 1;
                seen.clear();
            }
        }

        ans
    }
}