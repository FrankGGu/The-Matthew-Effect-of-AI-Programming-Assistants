use std::collections::HashSet;

impl Solution {
    pub fn relocate_marbles(nums: Vec<i32>, move_from: Vec<i32>, move_to: Vec<i32>) -> Vec<i32> {
        let mut marbles: HashSet<i32> = nums.into_iter().collect();

        for i in 0..move_from.len() {
            if marbles.contains(&move_from[i]) {
                marbles.remove(&move_from[i]);
                marbles.insert(move_to[i]);
            }
        }

        let mut result: Vec<i32> = marbles.into_iter().collect();
        result.sort();
        result
    }
}