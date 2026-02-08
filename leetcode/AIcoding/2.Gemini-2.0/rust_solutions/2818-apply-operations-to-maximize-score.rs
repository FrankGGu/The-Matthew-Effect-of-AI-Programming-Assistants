impl Solution {
    pub fn maximize_score(nums: Vec<i32>, i: Vec<i32>) -> i64 {
        let n = nums.len();
        let m = i.len();
        let mut primes: Vec<i32> = Vec::new();
        let mut is_prime = vec![true; 100001];
        is_prime[0] = false;
        is_prime[1] = false;
        for i in 2..=100000 {
            if is_prime[i] {
                primes.push(i as i32);
                let mut j = i * i;
                while j <= 100000 {
                    is_prime[j as usize] = false;
                    j += i;
                }
            }
        }

        fn prime_factorization(num: i32, primes: &Vec<i32>) -> i32 {
            let mut count = 1;
            let mut n = num;
            for &p in primes {
                if p * p > n {
                    break;
                }
                let mut c = 0;
                while n % p == 0 {
                    n /= p;
                    c += 1;
                }
                count *= (c + 1);
            }
            if n > 1 {
                count *= 2;
            }
            count
        }

        let mut factors: Vec<(i32, usize)> = nums.iter().enumerate().map(|(i, &num)| (prime_factorization(num, &primes), i)).collect();
        factors.sort_by(|a, b| b.0.cmp(&a.0));

        let mut visited = vec![false; n];
        let mut ans: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for &val in &i {
            let mut best_idx = usize::MAX;
            let mut best_factor = 0;

            for &(factor, idx) in &factors {
                if !visited[idx] {
                    if factor > best_factor {
                        best_factor = factor;
                        best_idx = idx;
                    }
                }
            }

            visited[best_idx] = true;
            ans = (ans + (nums[best_idx] as i64) % modulo) % modulo;
        }

        ans
    }
}