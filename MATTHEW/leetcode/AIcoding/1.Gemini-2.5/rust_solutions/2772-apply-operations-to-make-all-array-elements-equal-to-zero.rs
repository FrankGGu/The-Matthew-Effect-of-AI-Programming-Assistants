impl Solution {
    pub fn check_array_elements_equal_to_zero(nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        let k = k as usize;

        let mut diff_array: Vec<i64> = vec![0; n + 1];
        let mut current_effective_subtraction: i64 = 0;

        for i in 0..n {
            current_effective_subtraction += diff_array[i];

            let current_val_at_i = nums[i] as i64 - current_effective_subtraction;

            if i <= n - k {
                if current_val_at_i != 0 {
                    let x = current_val_at_i;
                    diff_array[i + k] -= x;
                    current_effective_subtraction += x;
                }
            } else {
                if current_val_at_i != 0 {
                    return false;
                }
            }
        }

        true
    }
}