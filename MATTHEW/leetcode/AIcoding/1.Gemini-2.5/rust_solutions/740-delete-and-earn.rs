impl Solution {
    pub fn delete_and_earn(nums: Vec<i32>) -> i32 {
        let mut max_val = 0;
        for &num in &nums {
            if num > max_val {
                max_val = num;
            }
        }

        let mut points = vec![0; (max_val + 1) as usize];
        for &num in &nums {
            points[num as usize] += num;
        }

        let mut dp_i_minus_2 = 0;
        let mut dp_i_minus_1 = 0;

        for i in 0..=max_val as usize {
            let current_dp = std::cmp::max(dp_i_minus_1, dp_i_minus_2 + points[i]);
            dp_i_minus_2 = dp_i_minus_1;
            dp_i_minus_1 = current_dp;
        }

        dp_i_minus_1
    }
}