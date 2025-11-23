impl Solution {
    pub fn count_subarrays_divisible_by_k(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut prefix_sum = 0;
        let mut mod_count = std::collections::HashMap::new();
        mod_count.insert(0, 1);

        for &num in &nums {
            prefix_sum += num;
            let mod_value = ((prefix_sum % k) + k) % k;
            count += mod_count.get(&mod_value).unwrap_or(&0);
            *mod_count.entry(mod_value).or_insert(0) += 1;
        }

        count
    }
}