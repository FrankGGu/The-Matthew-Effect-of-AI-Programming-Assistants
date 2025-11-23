use std::collections::HashSet;

impl Solution {
    pub fn relocate_marbles(nums: Vec<i32>, move_from: Vec<i32>, move_to: Vec<i32>) -> Vec<i32> {
        let mut marble_positions: HashSet<i32> = nums.into_iter().collect();

        for i in 0..move_from.len() {
            let from = move_from[i];
            let to = move_to[i];

            if marble_positions.remove(&from) {
                marble_positions.insert(to);
            }
        }

        let mut result: Vec<i32> = marble_positions.into_iter().collect();
        result.sort_unstable();
        result
    }
}