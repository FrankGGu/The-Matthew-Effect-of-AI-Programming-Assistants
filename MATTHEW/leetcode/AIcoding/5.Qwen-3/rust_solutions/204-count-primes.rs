struct Solution;

impl Solution {
    pub fn count_primes(n: i32) -> i32 {
        if n < 2 {
            return 0;
        }
        let mut is_prime = vec![true; n as usize];
        is_prime[0] = false;
        is_prime[1] = false;
        for i in 2..(n as f64).sqrt() as i32 + 1 {
            if is_prime[i as usize] {
                for j in (i * i)..n {
                    if j % i == 0 {
                        is_prime[j as usize] = false;
                    }
                }
            }
        }
        is_prime.iter().filter(|&&x| x).count() as i32
    }
}