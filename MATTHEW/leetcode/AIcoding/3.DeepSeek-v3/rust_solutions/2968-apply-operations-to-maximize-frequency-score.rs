impl Solution {
    pub fn max_frequency_score(nums: Vec<i32>, k: i64) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i] as i64;
        }

        let mut max_freq = 1;
        let mut left = 0;

        for right in 0..n {
            let median = nums[(left + right) / 2] as i64;
            let total_operations = median * (right - left + 1) as i64 - (prefix[right + 1] - prefix[left]);

            while total_operations > k {
                left += 1;
                let new_median = nums[(left + right) / 2] as i64;
                let new_total_operations = new_median * (right - left + 1) as i64 - (prefix[right + 1] - prefix[left]);
                if new_total_operations <= k {
                    break;
                }
            }

            max_freq = max_freq.max(right - left + 1);
        }

        max_freq as i32
    }
}