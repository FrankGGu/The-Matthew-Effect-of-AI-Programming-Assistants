impl Solution {
    pub fn k_mirror(k: i32, n: i32) -> i64 {
        let mut count = 0;
        let mut sum = 0;
        let mut len = 1;
        while count < n {
            let start = 10_i64.pow((len - 1) / 2);
            let end = 10_i64.pow(len / 2);
            for i in start..end {
                let mut num = i;
                let mut mirror = i;
                if len % 2 == 0 {
                    num /= 10;
                }
                while num > 0 {
                    mirror = mirror * 10 + num % 10;
                    num /= 10;
                }

                if Self::is_palindrome(mirror, k) {
                    sum += mirror;
                    count += 1;
                    if count == n {
                        break;
                    }
                }
            }
            len += 1;
        }
        sum
    }

    fn is_palindrome(mut num: i64, k: i32) -> bool {
        let mut digits = Vec::new();
        while num > 0 {
            digits.push(num % (k as i64));
            num /= k as i64;
        }
        let n = digits.len();
        for i in 0..n / 2 {
            if digits[i] != digits[n - 1 - i] {
                return false;
            }
        }
        true
    }
}