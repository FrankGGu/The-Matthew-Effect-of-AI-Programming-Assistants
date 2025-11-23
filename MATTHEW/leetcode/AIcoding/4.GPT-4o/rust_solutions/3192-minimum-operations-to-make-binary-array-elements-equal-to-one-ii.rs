impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut result = n as i32;
        let mut prefix_sum = vec![0; n + 1];

        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        for j in 1..=n {
            if prefix_sum[j] == j as i32 {
                result = result.min((n - j) as i32);
            }
        }

        for i in 0..n {
            let remaining = (prefix_sum[n] - prefix_sum[i]) - (n - i) as i32;
            if remaining == 0 {
                result = result.min(i as i32);
            }
        }

        result
    }
}