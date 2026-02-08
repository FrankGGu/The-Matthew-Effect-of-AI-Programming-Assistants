pub fn num_jewels_in_stones(jewels: String, stones: String) -> i32 {
    let jewel_set: std::collections::HashSet<_> = jewels.chars().collect();
    stones.chars().filter(|&stone| jewel_set.contains(&stone)).count() as i32
}