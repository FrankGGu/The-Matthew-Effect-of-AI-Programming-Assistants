impl Solution {
    pub fn running_sum(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::with_capacity(nums.len());
        let mut current_sum = 0;
        for num in nums {
            current_sum += num;
            result.push(current_sum);
        }
        result
    }
}