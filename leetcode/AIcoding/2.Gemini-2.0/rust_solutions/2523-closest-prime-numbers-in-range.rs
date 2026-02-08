impl Solution {
    pub fn closest_primes(left: i32, right: i32) -> Vec<i32> {
        let mut primes = Vec::new();
        let mut is_prime = vec![true; (right + 1) as usize];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=(right as f64).sqrt() as i32 {
            if is_prime[i as usize] {
                for j in (i * i..=right).step_by(i as usize) {
                    is_prime[j as usize] = false;
                }
            }
        }

        for i in left..=right {
            if is_prime[i as usize] {
                primes.push(i);
            }
        }

        if primes.len() < 2 {
            return vec![-1, -1];
        }

        let mut min_diff = i32::MAX;
        let mut result = vec![-1, -1];

        for i in 0..primes.len() - 1 {
            let diff = primes[i + 1] - primes[i];
            if diff < min_diff {
                min_diff = diff;
                result = vec![primes[i], primes[i + 1]];
            }
        }

        result
    }
}