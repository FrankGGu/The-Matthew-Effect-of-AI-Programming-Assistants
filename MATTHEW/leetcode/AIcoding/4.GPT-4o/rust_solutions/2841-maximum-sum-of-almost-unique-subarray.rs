impl Solution {
    pub fn maximum_sum(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = std::collections::HashMap::new();
        let mut max_sum = 0;
        let n = nums.len();

        for i in 0..n {
            *freq.entry(nums[i]).or_insert(0) += 1;
            if i >= k as usize {
                let remove_num = nums[i - k as usize];
                if let Some(count) = freq.get_mut(&remove_num) {
                    *count -= 1;
                    if *count == 0 {
                        freq.remove(&remove_num);
                    }
                }
            }
            if i >= k as usize - 1 {
                max_sum = max_sum.max(freq.keys().sum::<i32>());
            }
        }
        max_sum
    }
}