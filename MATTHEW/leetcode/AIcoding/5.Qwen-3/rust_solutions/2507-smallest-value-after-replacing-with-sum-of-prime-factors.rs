struct Solution;

impl Solution {
    pub fn sum_of_prime_factors(mut n: i32) -> i32 {
        let mut sum = 0;
        let mut i = 2;
        while i * i <= n {
            while n % i == 0 {
                sum += i;
                n /= i;
            }
            i += 1;
        }
        if n > 1 {
            sum += n;
        }
        sum
    }

    pub fn smallest_value(n: i32) -> i32 {
        let mut current = n;
        let mut seen = std::collections::HashSet::new();
        loop {
            if seen.contains(&current) {
                return current;
            }
            seen.insert(current);
            let next = Self::sum_of_prime_factors(current);
            if next == current {
                return current;
            }
            current = next;
        }
    }
}