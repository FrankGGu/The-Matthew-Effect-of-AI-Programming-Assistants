use std::collections::HashMap;

impl Solution {
    pub fn max_sum(nums: Vec<i32>) -> i32 {
        let mut max_digit_to_num = HashMap::new();
        let mut max_sum = -1;

        for &num in nums.iter() {
            let max_digit = Solution::get_max_digit(num);
            if let Some(&prev_num) = max_digit_to_num.get(&max_digit) {
                max_sum = max_sum.max(prev_num + num);
                if num > prev_num {
                    max_digit_to_num.insert(max_digit, num);
                }
            } else {
                max_digit_to_num.insert(max_digit, num);
            }
        }

        max_sum
    }

    fn get_max_digit(mut num: i32) -> i32 {
        let mut max_digit = 0;
        while num > 0 {
            let digit = num % 10;
            max_digit = max_digit.max(digit);
            num /= 10;
        }
        max_digit
    }
}