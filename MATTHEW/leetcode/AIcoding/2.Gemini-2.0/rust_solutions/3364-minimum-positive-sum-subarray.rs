impl Solution {
    pub fn min_positive_sum(nums: Vec<i32>) -> i32 {
        let mut min_sum = i32::MAX;
        for i in 0..nums.len() {
            let mut current_sum = 0;
            for j in i..nums.len() {
                current_sum += nums[j];
                if current_sum > 0 {
                    min_sum = min_sum.min(current_sum);
                }
            }
        }
        min_sum
    }
}