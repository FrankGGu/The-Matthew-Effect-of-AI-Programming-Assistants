impl Solution {
    pub fn average_value(nums: Vec<i32>) -> i32 {
        let (mut sum, mut count) = (0, 0);
        for &num in &nums {
            if num % 2 == 0 && num % 3 == 0 {
                sum += num;
                count += 1;
            }
        }
        if count == 0 {
            0
        } else {
            sum / count
        }
    }
}