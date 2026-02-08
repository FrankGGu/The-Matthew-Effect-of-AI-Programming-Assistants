impl Solution {
    pub fn minimize_array_value(nums: Vec<i32>) -> i32 {
        let mut max_value = 0;
        let mut total = 0;
        let mut count = 0;

        for &num in &nums {
            total += num;
            count += 1;
            max_value = max_value.max((total + count - 1) / count);
        }

        max_value
    }
}