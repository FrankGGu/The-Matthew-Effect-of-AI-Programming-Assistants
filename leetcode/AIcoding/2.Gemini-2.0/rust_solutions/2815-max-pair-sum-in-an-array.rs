impl Solution {
    pub fn max_sum(nums: Vec<i32>) -> i32 {
        let mut max_sum = -1;
        for i in 0..nums.len() {
            for j in i + 1..nums.len() {
                let max_digit_i = nums[i].to_string().chars().map(|c| c.to_digit(10).unwrap()).max().unwrap() as i32;
                let max_digit_j = nums[j].to_string().chars().map(|c| c.to_digit(10).unwrap()).max().unwrap() as i32;

                if max_digit_i == max_digit_j {
                    max_sum = max_sum.max(nums[i] + nums[j]);
                }
            }
        }
        max_sum
    }
}