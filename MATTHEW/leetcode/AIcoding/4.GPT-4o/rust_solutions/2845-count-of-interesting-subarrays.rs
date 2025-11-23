impl Solution {
    pub fn count_interesting_subarrays(nums: Vec<i32>, modulo: i32, k: i32) -> i32 {
        let mut count = 0;
        let mut prefix_sum = vec![0; nums.len() + 1];
        let mut mod_count = std::collections::HashMap::new();

        mod_count.insert(0, 1);

        for i in 0..nums.len() {
            prefix_sum[i + 1] = prefix_sum[i] + if nums[i] % modulo == k { 1 } else { 0 };
            let target = (prefix_sum[i + 1] - 1 + mod_count.len() as i32) % mod_count.len() as i32;
            count += mod_count.get(&target).unwrap_or(&0);
            *mod_count.entry(prefix_sum[i + 1] % mod_count.len() as i32).or_insert(0) += 1;
        }

        count
    }
}