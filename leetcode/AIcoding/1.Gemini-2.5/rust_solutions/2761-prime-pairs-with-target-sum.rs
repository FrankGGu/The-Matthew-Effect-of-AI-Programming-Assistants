impl Solution {
    pub fn find_prime_pairs(n: i32) -> Vec<i32> {
        if n < 4 {
            return vec![];
        }

        let n_usize = n as usize;
        let mut is_prime = vec![true; n_usize + 1];
        is_prime[0] = false;
        is_prime[1] = false;

        for p in 2..=(n_usize as f64).sqrt() as usize {
            if is_prime[p] {
                for multiple in (p * p..=n_usize).step_by(p) {
                    is_prime[multiple] = false;
                }
            }
        }

        for p1 in 2..=n / 2 {
            if is_prime[p1 as usize] {
                let p2 = n - p1;
                if is_prime[p2 as usize] {
                    return vec![p1, p2];
                }
            }
        }

        vec![]
    }
}