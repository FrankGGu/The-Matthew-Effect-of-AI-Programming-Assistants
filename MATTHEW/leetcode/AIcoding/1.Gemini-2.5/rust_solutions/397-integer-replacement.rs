impl Solution {
    pub fn integer_replacement(n_input: i32) -> i32 {
        let mut n: i64 = n_input as i64;
        let mut count = 0;

        while n != 1 {
            if n % 2 == 0 {
                n /= 2;
            } else {
                if n == 3 {
                    n -= 1;
                } else if (n / 2) % 2 == 0 { // n % 4 == 1
                    n -= 1;
                } else { // n % 4 == 3
                    n += 1;
                }
            }
            count += 1;
        }
        count
    }
}