impl Solution {
    pub fn num_prime_arrangements(n: i32) -> i32 {
        let modulo: i64 = 1_000_000_007;

        fn is_prime(num: i32) -> bool {
            if num <= 1 {
                return false;
            }
            if num == 2 || num == 3 {
                return true;
            }
            if num % 2 == 0 || num % 3 == 0 {
                return false;
            }
            let mut i = 5;
            while i * i <= num {
                if num % i == 0 || num % (i + 2) == 0 {
                    return false;
                }
                i += 6;
            }
            true
        }

        fn count_primes_up_to_n(n: i32) -> i32 {
            let mut count = 0;
            for i in 1..=n {
                if is_prime(i) {
                    count += 1;
                }
            }
            count
        }

        fn factorial_mod(k: i32, modulo: i64) -> i64 {
            let mut res: i64 = 1;
            for i in 1..=k {
                res = (res * i as i64) % modulo;
            }
            res
        }

        let prime_count = count_primes_up_to_n(n);
        let non_prime_count = n - prime_count;

        let fact_primes = factorial_mod(prime_count, modulo);
        let fact_non_primes = factorial_mod(non_prime_count, modulo);

        ((fact_primes * fact_non_primes) % modulo) as i32
    }
}