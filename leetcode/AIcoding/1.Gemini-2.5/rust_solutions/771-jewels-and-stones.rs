use std::collections::HashSet;

impl Solution {
    pub fn num_jewels_in_stones(jewels: String, stones: String) -> i32 {
        let jewel_set: HashSet<char> = jewels.chars().collect();
        let mut count = 0;
        for stone in stones.chars() {
            if jewel_set.contains(&stone) {
                count += 1;
            }
        }
        count
    }
}