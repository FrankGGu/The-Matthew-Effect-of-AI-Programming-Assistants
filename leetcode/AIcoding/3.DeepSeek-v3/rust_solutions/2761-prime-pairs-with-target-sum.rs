impl Solution {
    pub fn find_prime_pairs(n: i32) -> Vec<Vec<i32>> {
        if n < 2 {
            return vec![];
        }
        let mut sieve = vec![true; (n + 1) as usize];
        sieve[0] = false;
        sieve[1] = false;
        for i in 2..=(n as f64).sqrt() as i32 {
            if sieve[i as usize] {
                for j in (i * i..=n).step_by(i as usize) {
                    sieve[j as usize] = false;
                }
            }
        }
        let mut res = Vec::new();
        for x in 2..=n / 2 {
            let y = n - x;
            if sieve[x as usize] && sieve[y as usize] {
                res.push(vec![x, y]);
            }
        }
        res
    }
}