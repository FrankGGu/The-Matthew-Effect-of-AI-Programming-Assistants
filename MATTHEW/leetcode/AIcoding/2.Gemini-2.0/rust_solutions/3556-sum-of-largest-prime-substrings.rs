impl Solution {
    pub fn sum_of_largest_prime_substrings(s: String) -> i64 {
        let mut sum = 0;
        let n = s.len();
        for i in 0..n {
            for j in i + 1..=n {
                let sub = &s[i..j];
                if sub.len() > 0 {
                    if let Ok(num) = sub.parse::<i64>() {
                        if num <= 1000 && Solution::is_prime(num) {
                            sum += num;
                        }
                    }
                }
            }
        }
        sum
    }

    fn is_prime(n: i64) -> bool {
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
}