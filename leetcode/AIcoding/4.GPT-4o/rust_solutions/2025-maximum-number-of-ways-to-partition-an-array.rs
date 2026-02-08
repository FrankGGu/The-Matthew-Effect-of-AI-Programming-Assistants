impl Solution {
    pub fn ways_to_partition(nums: Vec<i32>, k: i32) -> i32 {
        let total_sum: i32 = nums.iter().sum();
        let mut count: i32 = 0;
        let mut prefix_sum = 0;
        let mut freq = std::collections::HashMap::new();

        for &num in &nums {
            prefix_sum += num;
            *freq.entry(prefix_sum).or_insert(0) += 1;
        }

        prefix_sum = 0;
        for &num in &nums {
            let remaining_sum = total_sum - prefix_sum - num;
            if let Some(&count_prefix) = freq.get(&(prefix_sum + k)) {
                count += count_prefix;
            }
            if let Some(&count_suffix) = freq.get(&(remaining_sum + k)) {
                count += count_suffix;
            }
            prefix_sum += num;
            *freq.get_mut(&prefix_sum).unwrap() -= 1;
        }

        count
    }
}