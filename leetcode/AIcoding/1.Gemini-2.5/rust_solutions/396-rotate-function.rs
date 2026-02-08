impl Solution {
    pub fn max_rotate_function(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut sum_nums: i64 = 0;
        let mut f0: i64 = 0;

        for (i, &num) in nums.iter().enumerate() {
            sum_nums += num as i64;
            f0 += (i as i64) * (num as i64);
        }

        let mut max_f = f0;
        let mut current_f = f0;

        for k in 0..(n - 1) {
            let last_element_in_current_rotation = nums[n - 1 - k] as i64;
            current_f = current_f - (n as i64) * last_element_in_current_rotation + sum_nums;
            max_f = max_f.max(current_f);
        }

        max_f as i32
    }
}