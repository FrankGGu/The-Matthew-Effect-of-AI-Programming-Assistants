impl Solution {
    pub fn num_prime_arrangements(n: i32) -> i32 {
        let mut count = 0;
        for i in 2..=n {
            if is_prime(i) {
                count += 1;
            }
        }
        let factorial = |x: i32| (1..=x).fold(1, |acc, v| (acc * v) % 1_000_000_007);
        (factorial(count) * factorial(n - count)) % 1_000_000_007
    }
}

fn is_prime(num: i32) -> bool {
    if num < 2 {
        return false;
    }
    for i in 2..=(num as f64).sqrt() as i32 {
        if num % i == 0 {
            return false;
        }
    }
    true
}