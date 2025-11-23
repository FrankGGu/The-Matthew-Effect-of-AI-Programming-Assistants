impl Solution {
    pub fn count_good_pairs(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut freq = std::collections::HashMap::new();

        for &num in &nums {
            count += freq.get(&(num - k)).unwrap_or(&0);
            count += freq.get(&(num + k)).unwrap_or(&0);
            *freq.entry(num).or_insert(0) += 1;
        }

        count
    }
}