impl Solution {
    pub fn integer_replacement(n: i32) -> i32 {
        let mut n = n as i64;
        let mut steps = 0;
        while n != 1 {
            if n % 2 == 0 {
                n /= 2;
            } else {
                if n == 3 {
                    n -= 1;
                } else {
                    if (n + 1) % 4 == 0 {
                        n += 1;
                    } else {
                        n -= 1;
                    }
                }
            }
            steps += 1;
        }
        steps
    }
}