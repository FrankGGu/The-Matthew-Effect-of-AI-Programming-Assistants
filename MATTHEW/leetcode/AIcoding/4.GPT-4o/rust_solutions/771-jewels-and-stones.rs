impl Solution {
    pub fn num_jewels_in_stones(jewels: String, stones: String) -> i32 {
        let jewel_set: std::collections::HashSet<_> = jewels.chars().collect();
        stones.chars().filter(|&c| jewel_set.contains(&c)).count() as i32
    }
}