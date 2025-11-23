use std::collections::HashSet;

impl Solution {
    pub fn distinct_prime_factors(nums: Vec<i32>) -> i32 {
        let mut distinct_factors: HashSet<i32> = HashSet::new();

        for mut num in nums {
            let mut d = 2;
            while d * d <= num {
                if num % d == 0 {
                    distinct_factors.insert(d);
                    while num % d == 0 {
                        num /= d;
                    }
                }
                d += 1;
            }
            if num > 1 {
                distinct_factors.insert(num);
            }
        }

        distinct_factors.len() as i32
    }
}