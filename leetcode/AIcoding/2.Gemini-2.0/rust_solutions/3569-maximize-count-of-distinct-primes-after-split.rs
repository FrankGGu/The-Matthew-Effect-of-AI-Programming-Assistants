impl Solution {
    pub fn max_distinct_primes(nums: Vec<i32>) -> i32 {
        let mut primes: Vec<i32> = Vec::new();
        let mut count: i32 = 0;

        for num in nums {
            let mut n = num;
            let mut current_primes: Vec<i32> = Vec::new();
            for i in 2..=((n as f64).sqrt() as i32) {
                if n % i == 0 {
                    current_primes.push(i);
                    while n % i == 0 {
                        n /= i;
                    }
                }
            }
            if n > 1 {
                current_primes.push(n);
            }

            let mut distinct = true;
            for p in current_primes.iter() {
                if primes.contains(p) {
                    distinct = false;
                    break;
                }
            }

            if distinct {
                count += 1;
                primes.extend(current_primes);
                primes.sort();
                primes.dedup();
            } else {
                count += 1;
            }
        }

        count
    }
}