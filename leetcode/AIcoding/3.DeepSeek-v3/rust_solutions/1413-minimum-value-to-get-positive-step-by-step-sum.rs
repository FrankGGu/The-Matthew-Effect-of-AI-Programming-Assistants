impl Solution {
    pub fn min_start_value(nums: Vec<i32>) -> i32 {
        let mut min_sum = 0;
        let mut current_sum = 0;
        for num in nums {
            current_sum += num;
            if current_sum < min_sum {
                min_sum = current_sum;
            }
        }
        1 - min_sum
    }
}