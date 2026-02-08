impl Solution {
    pub fn smallest_value(n: i32) -> i32 {
        let mut n = n;
        loop {
            let sum = Self::sum_prime_factors(n);
            if sum == n {
                break;
            }
            n = sum;
        }
        n
    }

    fn sum_prime_factors(mut x: i32) -> i32 {
        let mut sum = 0;
        let mut i = 2;
        while i * i <= x {
            while x % i == 0 {
                sum += i;
                x /= i;
            }
            i += 1;
        }
        if x > 1 {
            sum += x;
        }
        sum
    }
}