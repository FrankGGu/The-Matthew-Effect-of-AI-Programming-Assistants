use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(nums: Vec<i32>, k: i32) -> i64 {
        let mut freq = HashMap::new();
        let mut res = 0i64;
        for &num in nums.iter() {
            let gcd_num = Self::gcd(num, k);
            for (&gcd_other, &count) in freq.iter() {
                if (gcd_num * gcd_other) % k == 0 {
                    res += count as i64;
                }
            }
            *freq.entry(gcd_num).or_insert(0) += 1;
        }
        res
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 { a } else { Self::gcd(b, a % b) }
    }
}