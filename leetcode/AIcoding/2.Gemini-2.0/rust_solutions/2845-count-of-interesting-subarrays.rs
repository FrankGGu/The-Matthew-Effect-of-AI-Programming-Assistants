impl Solution {
    pub fn count_interesting_subarrays(nums: Vec<i32>, modulo: i32, k: i32) -> i64 {
        let n = nums.len();
        let mut prefix_sums = vec![0; n + 1];
        for i in 0..n {
            prefix_sums[i + 1] = (prefix_sums[i] + (nums[i] % modulo == 0) as i32) % modulo;
        }

        let mut count = 0;
        for i in 0..n {
            for j in i..n {
                let sum = (prefix_sums[j + 1] - prefix_sums[i] + modulo) % modulo;
                if (sum % modulo == k) {
                    count += 1;
                }
            }
        }

        count as i64
    }
}