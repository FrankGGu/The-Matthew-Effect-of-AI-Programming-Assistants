impl Solution {
    pub fn num_jewels_in_stones(jewels: String, stones: String) -> i32 {
        let jewels_set: std::collections::HashSet<char> = jewels.chars().collect();
        stones.chars().filter(|c| jewels_set.contains(c)).count() as i32
    }
}