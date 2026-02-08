impl Solution {
    pub fn maximum_prime_difference(nums: Vec<i32>) -> i32 {
        let max_val = 100;
        let mut is_prime = vec![true; max_val + 1];
        if max_val >= 0 {
            is_prime[0] = false;
        }
        if max_val >= 1 {
            is_prime[1] = false;
        }

        for p in 2..=(max_val as f64).sqrt() as usize {
            if is_prime[p] {
                for multiple in (p * p)..=max_val {
                    if multiple % p == 0 {
                        is_prime[multiple] = false;
                    }
                }
            }
        }

        let mut first_prime_idx = -1;
        let mut last_prime_idx = -1;

        for (i, &num) in nums.iter().enumerate() {
            if is_prime[num as usize] {
                if first_prime_idx == -1 {
                    first_prime_idx = i as i32;
                }
                last_prime_idx = i as i32;
            }
        }

        last_prime_idx - first_prime_idx
    }
}