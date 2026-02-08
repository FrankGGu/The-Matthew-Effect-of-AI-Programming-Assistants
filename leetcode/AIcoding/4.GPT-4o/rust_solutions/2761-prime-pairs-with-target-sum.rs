impl Solution {
    pub fn prime_pairs(target: i32) -> Vec<Vec<i32>> {
        let is_prime = |n: i32| {
            if n < 2 { return false; }
            for i in 2..=((n as f64).sqrt() as i32) {
                if n % i == 0 {
                    return false;
                }
            }
            true
        };

        let primes: Vec<i32> = (2..=target).filter(|&x| is_prime(x)).collect();
        let mut result = Vec::new();

        let mut left = 0;
        let mut right = primes.len() as i32 - 1;

        while left <= right {
            let sum = primes[left as usize] + primes[right as usize];
            if sum < target {
                left += 1;
            } else if sum > target {
                right -= 1;
            } else {
                result.push(vec![primes[left as usize], primes[right as usize]]);
                left += 1;
                right -= 1;
            }
        }

        result
    }
}