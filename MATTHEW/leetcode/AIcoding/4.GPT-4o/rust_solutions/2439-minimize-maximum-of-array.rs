impl Solution {
    pub fn minimize_array_value(nums: Vec<i32>) -> i32 {
        let mut max_value = 0;
        let mut sum = 0;
        for (i, &num) in nums.iter().enumerate() {
            sum += num;
            max_value = max_value.max((sum + i as i32) / (i as i32 + 1));
        }
        max_value
    }
}