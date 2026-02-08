impl Solution {
    pub fn prime_subtraction_operation(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut nums = nums;
        let mut prev = 0;
        let primes = Self::sieve(1000);

        for i in 0..n {
            let mut found = false;
            for &p in &primes {
                if nums[i] - p > prev && nums[i] - p > 0 {
                    nums[i] -= p;
                    prev = nums[i];
                    found = true;
                    break;
                }
            }
            if !found && nums[i] <= prev {
                return false;
            } else if !found {
                prev = nums[i];
            }
        }

        true
    }

    fn sieve(n: usize) -> Vec<i32> {
        let mut is_prime = vec![true; n + 1];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=(n as f64).sqrt() as usize {
            if is_prime[i] {
                for j in (i * i..=n).step_by(i) {
                    is_prime[j] = false;
                }
            }
        }

        let mut primes = Vec::new();
        for i in 2..=n {
            if is_prime[i] {
                primes.push(i as i32);
            }
        }

        primes
    }
}