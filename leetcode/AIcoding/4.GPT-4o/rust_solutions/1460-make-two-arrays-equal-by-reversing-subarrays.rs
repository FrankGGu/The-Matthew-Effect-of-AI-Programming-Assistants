impl Solution {
    pub fn can_be_equal(target: Vec<i32>, arr: Vec<i32>) -> bool {
        let mut target_count = std::collections::HashMap::new();
        let mut arr_count = std::collections::HashMap::new();

        for &num in &target {
            *target_count.entry(num).or_insert(0) += 1;
        }

        for &num in &arr {
            *arr_count.entry(num).or_insert(0) += 1;
        }

        target_count == arr_count
    }
}