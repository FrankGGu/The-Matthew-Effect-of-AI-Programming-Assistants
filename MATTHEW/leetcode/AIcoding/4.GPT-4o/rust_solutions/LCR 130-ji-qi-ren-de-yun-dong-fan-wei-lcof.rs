impl Solution {
    pub fn min_steps_to_sort_closet(closet: Vec<char>) -> i32 {
        let mut counts = std::collections::HashMap::new();
        for item in closet {
            *counts.entry(item).or_insert(0) += 1;
        }
        let max_count = *counts.values().max().unwrap();
        closet.len() as i32 - max_count
    }
}