impl Solution {
    pub fn relocate_marbles(nums: Vec<i32>, move_from: Vec<i32>, move_to: Vec<i32>) -> Vec<i32> {
        use std::collections::HashSet;
        let mut positions: HashSet<i32> = nums.into_iter().collect();
        for (from, to) in move_from.into_iter().zip(move_to.into_iter()) {
            if positions.remove(&from) {
                positions.insert(to);
            }
        }
        let mut result: Vec<i32> = positions.into_iter().collect();
        result.sort();
        result
    }
}