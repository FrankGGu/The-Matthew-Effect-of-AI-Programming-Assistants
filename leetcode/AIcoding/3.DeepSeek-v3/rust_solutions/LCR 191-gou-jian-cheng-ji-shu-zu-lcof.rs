impl Solution {
    pub fn calculate_statistics(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut sum = 0;
        let mut max = i32::MIN;
        let mut min = i32::MAX;
        let mut count = 0;

        for &num in &nums {
            sum += num;
            if num > max {
                max = num;
            }
            if num < min {
                min = num;
            }
            count += 1;
        }

        result.push(min);
        result.push(max);
        result.push(sum / count);
        result
    }
}