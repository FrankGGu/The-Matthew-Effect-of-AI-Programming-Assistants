impl Solution {
    pub fn count_primes(n: i32) -> i32 {
        if n <= 2 {
            return 0;
        }
        let n = n as usize;
        let mut is_prime = vec![true; n];
        is_prime[0] = false;
        is_prime[1] = false;
        for i in 2..=(n as f64).sqrt() as usize {
            if is_prime[i] {
                for j in (i * i..n).step_by(i) {
                    is_prime[j] = false;
                }
            }
        }
        is_prime.iter().filter(|&&x| x).count() as i32
    }
}