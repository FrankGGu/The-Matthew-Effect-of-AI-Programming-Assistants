impl Solution {
    pub fn largest_prime_substring(s: String) -> i32 {
        fn is_prime(n: i32) -> bool {
            if n < 2 {
                return false;
            }
            for i in 2..=((n as f64).sqrt() as i32) {
                if n % i == 0 {
                    return false;
                }
            }
            true
        }

        let mut max_prime = -1;
        let n = s.len();

        for i in 0..n {
            for j in i + 1..=n {
                let substring = &s[i..j];
                if substring.chars().all(|c| c.is_digit(10)) {
                    let num = substring.parse::<i32>().unwrap();
                    if is_prime(num) {
                        max_prime = max_prime.max(num);
                    }
                }
            }
        }

        max_prime
    }
}