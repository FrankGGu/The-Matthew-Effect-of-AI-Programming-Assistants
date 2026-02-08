impl Solution {
    pub fn maximum_or(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        let mut suffix = vec![0; n + 1];

        for i in 0..n {
            prefix[i + 1] = prefix[i] | (nums[i] as i64);
        }

        for i in (0..n).rev() {
            suffix[i] = suffix[i + 1] | (nums[i] as i64);
        }

        let mut max_or = 0;
        for i in 0..n {
            let current = (nums[i] as i64) << k;
            max_or = max_or.max(prefix[i] | current | suffix[i + 1]);
        }

        max_or
    }
}