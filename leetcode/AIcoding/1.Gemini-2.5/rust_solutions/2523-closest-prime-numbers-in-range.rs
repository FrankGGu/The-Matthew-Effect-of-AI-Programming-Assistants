impl Solution {
    pub fn closest_primes(left: i32, right: i32) -> Vec<i32> {
        let max_val = right as usize;
        let mut is_prime = vec![true; max_val + 1];
        if max_val >= 0 {
            is_prime[0] = false;
        }
        if max_val >= 1 {
            is_prime[1] = false;
        }

        for p in 2..=(max_val as f64).sqrt() as usize {
            if is_prime[p] {
                for multiple in (p * p..=max_val).step_by(p) {
                    is_prime[multiple] = false;
                }
            }
        }

        let mut primes_in_range = Vec::new();
        for i in left..=right {
            if is_prime[i as usize] {
                primes_in_range.push(i);
            }
        }

        if primes_in_range.len() < 2 {
            return vec![-1, -1];
        }

        let mut min_diff = i32::MAX;
        let mut result = vec![-1, -1];

        for i in 0..primes_in_range.len() - 1 {
            let p1 = primes_in_range[i];
            let p2 = primes_in_range[i + 1];
            let diff = p2 - p1;

            if diff < min_diff {
                min_diff = diff;
                result[0] = p1;
                result[1] = p2;
            }
        }

        result
    }
}