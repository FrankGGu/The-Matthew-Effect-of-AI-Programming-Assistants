impl Solution {
    pub fn num_prime_arrangements(n: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let n = n as usize;
        let primes = (2..=n).filter(|&x| is_prime(x)).count();
        let non_primes = n - primes;

        (factorial(primes) * factorial(non_primes) % MOD) as i32
    }
}

fn is_prime(n: usize) -> bool {
    if n <= 1 {
        return false;
    }
    if n == 2 {
        return true;
    }
    if n % 2 == 0 {
        return false;
    }
    let sqrt_n = (n as f64).sqrt() as usize;
    for i in (3..=sqrt_n).step_by(2) {
        if n % i == 0 {
            return false;
        }
    }
    true
}

fn factorial(n: usize) -> i64 {
    let mut res = 1;
    for i in 1..=n {
        res = res * i as i64 % 1_000_000_007;
    }
    res
}