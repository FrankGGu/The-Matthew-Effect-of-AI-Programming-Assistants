use std::collections::HashSet;

impl Solution {
    pub fn max_split_array(nums: Vec<i32>) -> i32 {
        let mut right_factors: Vec<HashSet<i32>> = Vec::new();
        for i in 0..nums.len() {
            let mut factors = HashSet::new();
            let mut n = nums[i];
            for j in 2..=((n as f64).sqrt() as i32) {
                while n % j == 0 {
                    factors.insert(j);
                    n /= j;
                }
            }
            if n > 1 {
                factors.insert(n);
            }
            right_factors.push(factors);
        }

        let mut left_factors: HashSet<i32> = HashSet::new();
        let mut ans = 0;
        for i in 0..nums.len() - 1 {
            let mut n = nums[i];
            let mut factors = HashSet::new();
            for j in 2..=((n as f64).sqrt() as i32) {
                while n % j == 0 {
                    factors.insert(j);
                    n /= j;
                }
            }
            if n > 1 {
                factors.insert(n);
            }

            for factor in factors.iter() {
                left_factors.insert(*factor);
            }

            let mut coprime = true;
            for j in i + 1..nums.len() {
                for factor in right_factors[j].iter() {
                    if left_factors.contains(factor) {
                        coprime = false;
                        break;
                    }
                }
                if !coprime {
                    break;
                }
            }

            if coprime {
                ans += 1;
                left_factors.clear();
            }
        }

        ans + 1
    }
}