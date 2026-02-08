impl Solution {
    pub fn separate_digits(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        for mut num in nums {
            if num == 0 {
                result.push(0);
                continue;
            }
            let mut digits_in_reverse = Vec::new();
            while num > 0 {
                digits_in_reverse.push(num % 10);
                num /= 10;
            }
            for i in (0..digits_in_reverse.len()).rev() {
                result.push(digits_in_reverse[i]);
            }
        }
        result
    }
}