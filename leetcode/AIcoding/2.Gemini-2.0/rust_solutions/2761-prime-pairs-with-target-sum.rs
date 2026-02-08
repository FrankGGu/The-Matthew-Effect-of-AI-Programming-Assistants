impl Solution {
    pub fn find_prime_pairs(n: i32) -> Vec<Vec<i32>> {
        if n <= 1 {
            return vec![];
        }

        let mut is_prime = vec![true; n as usize + 1];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=((n as f64).sqrt() as i32) {
            if is_prime[i as usize] {
                for j in (i * i..=n).step_by(i as usize) {
                    is_prime[j as usize] = false;
                }
            }
        }

        let mut result = vec![];
        for i in 2..=(n / 2) {
            if is_prime[i as usize] && is_prime[(n - i) as usize] {
                result.push(vec![i, n - i]);
            }
        }

        result
    }
}