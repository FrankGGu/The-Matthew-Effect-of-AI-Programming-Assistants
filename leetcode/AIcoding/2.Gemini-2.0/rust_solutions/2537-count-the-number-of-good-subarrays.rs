use std::collections::HashMap;

impl Solution {
    pub fn count_good_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let mut count: i64 = 0;
        let mut prefix_xor: i32 = 0;
        let mut freq: HashMap<i32, i64> = HashMap::new();
        freq.insert(0, 1);

        for &num in &nums {
            prefix_xor ^= num;
            let mut needed_xor: i32 = 0;
            let mut current_count: i64 = 0;
            for (&key, &value) in &freq {
                if (prefix_xor ^ key) <= k {
                   current_count += value;
                }
            }
            count += freq.iter().filter(|(&key, _)| (prefix_xor ^ key) <= k).map(|(_, &v)| v).sum::<i64>();

            *freq.entry(prefix_xor).or_insert(0) += 1;
        }

        let mut count: i64 = 0;
        let mut left: usize = 0;
        let mut xor_sum: i32 = 0;
        let mut freq: HashMap<i32, i32> = HashMap::new();

        for right in 0..nums.len() {
            xor_sum ^= nums[right];
            *freq.entry(nums[right]).or_insert(0) += 1;

            while freq.values().map(|&x| x as i32).sum::<i32>() as i64 > k as i64 {
                *freq.entry(nums[left]).or_insert(0) -= 1;
                if freq[&nums[left]] == 0 {
                    freq.remove(&nums[left]);
                }
                xor_sum ^= nums[left];
                left += 1;
            }
            count += (left as i64);
        }

        return count;
    }
}