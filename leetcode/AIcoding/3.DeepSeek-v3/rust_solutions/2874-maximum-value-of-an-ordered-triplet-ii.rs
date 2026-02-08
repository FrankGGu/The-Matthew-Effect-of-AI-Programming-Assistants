impl Solution {
    pub fn maximum_triplet_value(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut prefix_max = vec![0; n];
        prefix_max[0] = nums[0] as i64;
        for i in 1..n {
            prefix_max[i] = prefix_max[i - 1].max(nums[i] as i64);
        }

        let mut suffix_max = vec![0; n];
        suffix_max[n - 1] = nums[n - 1] as i64;
        for i in (0..n - 1).rev() {
            suffix_max[i] = suffix_max[i + 1].max(nums[i] as i64);
        }

        let mut max_val = 0;
        for j in 1..n - 1 {
            let val = (prefix_max[j - 1] - nums[j] as i64) * suffix_max[j + 1];
            if val > max_val {
                max_val = val;
            }
        }

        max_val.max(0)
    }
}