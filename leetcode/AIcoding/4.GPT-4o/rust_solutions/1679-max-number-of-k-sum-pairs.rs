impl Solution {
    pub fn max_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut counts = std::collections::HashMap::new();
        let mut operations = 0;

        for &num in &nums {
            let complement = k - num;
            if let Some(&count) = counts.get(&complement) {
                if count > 0 {
                    operations += 1;
                    counts.insert(complement, count - 1);
                }
            }
            *counts.entry(num).or_insert(0) += 1;
        }

        operations
    }
}