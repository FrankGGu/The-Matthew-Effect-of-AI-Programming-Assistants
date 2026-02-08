impl Solution {
    pub fn count_distinct_integers(n: i32) -> i32 {
        if n == 1 {
            return 1;
        }

        let mut count = 0;
        let mut i = 1;
        while i * i <= n {
            if n % i == 0 {
                // If i divides n, then i and n/i are divisors.
                // Add 2 to count for both.
                count += 2;
                // If i * i == n, then i and n/i are the same number,
                // so we counted it twice. Subtract 1.
                if i * i == n {
                    count -= 1;
                }
            }
            i += 1;
        }
        count
    }
}