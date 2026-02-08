impl Solution {
    pub fn can_be_equal(target: String, arr: Vec<String>) -> bool {
        let mut target_counts = std::collections::HashMap::new();
        let mut arr_counts = std::collections::HashMap::new();

        for ch in target.chars() {
            *target_counts.entry(ch).or_insert(0) += 1;
        }

        for ch in arr {
            *arr_counts.entry(ch.chars().next().unwrap()).or_insert(0) += 1;
        }

        target_counts == arr_counts
    }
}