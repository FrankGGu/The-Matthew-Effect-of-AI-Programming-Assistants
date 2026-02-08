use std::collections::HashMap;

impl Solution {
    pub fn reordered_power_of2(n: i32) -> bool {
        let target_digits = Solution::count_digits(n);
        for i in 0..31 {
            let power = 1 << i;
            let power_digits = Solution::count_digits(power);
            if power_digits == target_digits {
                return true;
            }
        }
        false
    }

    fn count_digits(n: i32) -> HashMap<i32, i32> {
        let mut digits = HashMap::new();
        let mut num = n;
        while num > 0 {
            let digit = num % 10;
            *digits.entry(digit).or_insert(0) += 1;
            num /= 10;
        }
        digits
    }
}