impl Solution {
    pub fn maximum_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut max_sum = 0;
        let mut current_sum = 0;
        let mut freq = std::collections::HashMap::new();

        for i in 0..nums.len() {
            current_sum += nums[i];
            *freq.entry(nums[i]).or_insert(0) += 1;

            if i >= k {
                current_sum -= nums[i - k];
                let count = freq.entry(nums[i - k]).or_insert(0);
                *count -= 1;
                if *count == 0 {
                    freq.remove(&nums[i - k]);
                }
            }

            if i >= k - 1 && freq.len() == k {
                max_sum = max_sum.max(current_sum);
            }
        }

        max_sum
    }
}