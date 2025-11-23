impl Solution {
    pub fn minimum_cost(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut min_sum_of_second_and_third_elements = std::i32::MAX;

        for i in 1..n - 1 {
            for j in i + 1..n {
                min_sum_of_second_and_third_elements = min_sum_of_second_and_third_elements.min(nums[i] + nums[j]);
            }
        }

        nums[0] + min_sum_of_second_and_third_elements
    }
}