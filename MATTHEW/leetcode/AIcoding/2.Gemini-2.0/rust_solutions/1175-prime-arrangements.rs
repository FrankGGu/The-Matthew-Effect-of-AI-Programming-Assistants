impl Solution {
    pub fn num_prime_arrangements(n: i32) -> i32 {
        let mut count = 0;
        for i in 2..=n {
            if Solution::is_prime(i) {
                count += 1;
            }
        }

        let prime_factorial = Solution::factorial(count) as i64;
        let non_prime_factorial = Solution::factorial(n - count) as i64;

        ((prime_factorial * non_prime_factorial) % 1000000007) as i32
    }

    fn is_prime(n: i32) -> bool {
        if n <= 1 {
            return false;
        }
        let mut i = 2;
        while i * i <= n {
            if n % i == 0 {
                return false;
            }
            i += 1;
        }
        true
    }

    fn factorial(n: i32) -> i32 {
        let mut result = 1;
        for i in 2..=n {
            result = (result as i64 * i as i64 % 1000000007) as i32;
        }
        result
    }
}

struct Solution;