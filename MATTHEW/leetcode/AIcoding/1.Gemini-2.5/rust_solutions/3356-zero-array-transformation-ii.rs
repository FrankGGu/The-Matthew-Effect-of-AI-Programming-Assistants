impl Solution {
    pub fn zero_array(mut nums: Vec<i64>, k: i32) -> i64 {
        let n = nums.len();
        let k_val = k as i64;
        let mut total_operations: i64 = 0;

        for i in 0..n {
            if nums[i] == 0 {
                continue;
            }

            if nums[i] < 0 {
                return -1;
            }

            let ops_needed = (nums[i] + k_val - 1) / k_val;
            total_operations += ops_needed;

            if i + 1 < n {
                nums[i + 1] += nums[i];
            }
        }

        total_operations
    }
}