impl Solution {
    pub fn closest_primes(left: i32, right: i32) -> Vec<i32> {
        let mut primes = vec![true; (right + 1) as usize];
        primes[0] = false;
        primes[1] = false;

        for i in 2..=((right as f64).sqrt() as usize) {
            if primes[i] {
                for j in (i * i..=right as usize).step_by(i) {
                    primes[j] = false;
                }
            }
        }

        let mut last_prime = -1;
        let mut closest_pair = vec![-1, -1];

        for i in left..=right {
            if primes[i as usize] {
                if last_prime != -1 {
                    if closest_pair[0] == -1 || (i - last_prime < closest_pair[1] - closest_pair[0]) {
                        closest_pair = vec![last_prime, i];
                    }
                }
                last_prime = i;
            }
        }

        closest_pair
    }
}