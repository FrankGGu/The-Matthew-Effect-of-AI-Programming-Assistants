impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn different_subsequence_gcds(nums: Vec<i32>) -> i32 {
        let mut max_num = 0;
        for &num in &nums {
            max_num = max_num.max(num);
        }

        let mut seen = HashSet::new();
        for &num in &nums {
            seen.insert(num);
        }

        let mut result = 0;
        for g in 1..=max_num {
            let mut current_gcd = 0;
            for num in &nums {
                if *num % g == 0 {
                    current_gcd = gcd(current_gcd, *num);
                }
            }
            if current_gcd == g {
                result += 1;
            }
        }

        result
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}

struct Solution {}
}