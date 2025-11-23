impl Solution {

use std::cmp::min;

struct Solution {}

impl Solution {
    pub fn find_gcd(nums: Vec<i32>) -> i32 {
        let mut min_val = nums[0];
        let mut max_val = nums[0];

        for &num in &nums {
            if num < min_val {
                min_val = num;
            }
            if num > max_val {
                max_val = num;
            }
        }

        let mut a = min_val;
        let mut b = max_val;

        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }

        a
    }
}
}