impl Solution {
    pub fn max_array_value(nums: Vec<i32>) -> i64 {
        let n = nums.len();

        let mut current_sum: i64 = nums[n - 1] as i64;
        let mut max_val: i64 = current_sum;

        for i in (0..n - 1).rev() {
            let num = nums[i] as i64;
            if num <= current_sum {
                current_sum += num;
            } else {
                current_sum = num;
            }
            max_val = max_val.max(current_sum);
        }

        max_val
    }
}