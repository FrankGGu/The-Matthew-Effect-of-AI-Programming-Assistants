impl Solution {
    pub fn maximum_or(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut max_or_val: i64 = 0;

        for i in 0..n {
            for j in 0..n {
                let val_i = nums[i] as i64;
                let val_j_shifted = (nums[j] as i64) << k;
                let current_or = val_i | val_j_shifted;
                if current_or > max_or_val {
                    max_or_val = current_or;
                }
            }
        }
        max_or_val
    }
}