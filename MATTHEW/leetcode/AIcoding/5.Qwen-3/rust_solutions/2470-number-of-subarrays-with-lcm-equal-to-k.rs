impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn num_subarrays_with_lcm_divisible_by_k(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let n = nums.len();

        for i in 0..n {
            let mut current_lcm = 1;
            for j in i..n {
                current_lcm = lcm(current_lcm, nums[j]);
                if current_lcm % k != 0 {
                    break;
                }
                count += 1;
            }
        }

        count
    }

    fn gcd(a: i32, b: i32) -> i32 {
        match b.cmp(&0) {
            Ordering::Equal => a,
            _ => Self::gcd(b, a % b),
        }
    }

    fn lcm(a: i32, b: i32) -> i32 {
        a * b / Self::gcd(a, b)
    }
}
}