impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn maximum_sum(nums: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        let mut max_sum = -1;

        for num in nums {
            let sum = digit_sum(num);
            if let Some(&prev) = map.get(&sum) {
                max_sum = std::cmp::max(max_sum, prev + num);
            }
            map.insert(sum, std::cmp::max(*map.get(&sum).unwrap_or(&-1), num));
        }

        max_sum
    }

    fn digit_sum(mut num: i32) -> i32 {
        let mut sum = 0;
        while num > 0 {
            sum += num % 10;
            num /= 10;
        }
        sum
    }
}
}