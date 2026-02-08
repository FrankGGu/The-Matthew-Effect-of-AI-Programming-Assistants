impl Solution {
    pub fn count_digit_one(n: i32) -> i32 {
        let mut count = 0;
        let mut i = 1;
        let mut n = n as i64;

        while i <= n {
            let high = n / (i * 10);
            let cur = (n / i) % 10;
            let low = n % i;

            if cur == 0 {
                count += high * i;
            } else if cur == 1 {
                count += high * i + low + 1;
            } else {
                count += (high + 1) * i;
            }

            i *= 10;
        }

        count as i32
    }
}