impl Solution {
    pub fn count_primes(n: i32) -> i32 {
        if n < 3 {
            return 0;
        }

        let n_usize = n as usize;
        let mut is_prime = vec![true; n_usize];

        is_prime[0] = false;
        is_prime[1] = false;

        let mut count = 0;

        for p in 2..n_usize {
            if is_prime[p] {
                count += 1;

                let mut multiple = p * p;
                while multiple < n_usize {
                    is_prime[multiple] = false;
                    multiple += p;
                }
            }
        }

        count
    }
}