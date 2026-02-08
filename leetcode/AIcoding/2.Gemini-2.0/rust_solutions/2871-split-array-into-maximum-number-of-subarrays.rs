impl Solution {
    pub fn max_number_of_subarrays(nums: Vec<i32>) -> i32 {
        let mut result = 0;
        let mut current_and = -1;
        for &num in &nums {
            current_and &= num;
            if current_and == 0 {
                result += 1;
                current_and = -1;
            }
        }
        if current_and != -1 {
            if current_and == 0 {
                result += 1;
            } else {
                result = 1;
            }
        }
        result
    }
}