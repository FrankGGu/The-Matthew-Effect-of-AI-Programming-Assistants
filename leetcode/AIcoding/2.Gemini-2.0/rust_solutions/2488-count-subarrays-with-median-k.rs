use std::collections::HashMap;

impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut k_index = -1;
        for i in 0..n {
            if nums[i] == k {
                k_index = i as i32;
                break;
            }
        }

        let mut ans = 0;
        let mut prefix_sums = vec![0; n + 1];
        for i in 0..n {
            if nums[i] < k {
                prefix_sums[i + 1] = prefix_sums[i] - 1;
            } else if nums[i] > k {
                prefix_sums[i + 1] = prefix_sums[i] + 1;
            } else {
                prefix_sums[i + 1] = prefix_sums[i];
            }
        }

        let mut count = HashMap::new();
        count.insert(0, 1);

        for i in (k_index as usize..n) {
            let sum = prefix_sums[i + 1] - prefix_sums[k_index as usize];
            let zero_count = count.entry(sum).or_insert(0);
            *zero_count += 1;
        }

        for i in (0..=k_index as usize).rev() {
            let sum = prefix_sums[k_index as usize] - prefix_sums[i];
            ans += *count.get(&sum).unwrap_or(&0);
            ans += *count.get(&(sum - 1)).unwrap_or(&0);
        }

        ans
    }
}