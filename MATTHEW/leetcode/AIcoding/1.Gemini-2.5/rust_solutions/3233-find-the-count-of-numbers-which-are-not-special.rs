struct Solution;

impl Solution {
    pub fn non_special_numbers(left: i32, right: i32) -> i32 {
        let l = left as i64;
        let r = right as i64;

        let limit_for_sieve = (r as f64).sqrt().floor() as usize;

        if limit_for_sieve < 2 {
            return (r - l + 1) as i32;
        }

        let mut is_prime = vec![true; limit_for_sieve + 1];
        is_prime[0] = false;
        if limit_for_sieve >= 1 {
            is_prime[1] = false;
        }

        for p in 2..=limit_for_sieve {
            if is_prime[p] {
                let mut multiple = p * p;
                while multiple <= limit_for_sieve {
                    is_prime[multiple] = false;
                    multiple += p;
                }
            }
        }

        let mut special_count = 0;
        for p in 2..=limit_for_sieve {
            if is_prime[p] {
                let p_squared = p as i64 * p as i64;
                if p_squared >= l && p_squared <= r {
                    special_count += 1;
                }
            }
        }

        ((r - l + 1) - special_count) as i32
    }
}