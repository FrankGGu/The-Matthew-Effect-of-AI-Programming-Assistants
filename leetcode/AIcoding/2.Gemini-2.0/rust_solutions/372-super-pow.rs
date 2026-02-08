impl Solution {
    pub fn super_pow(a: i32, b: Vec<i32>) -> i32 {
        let mut res: i64 = 1;
        let a: i64 = (a % 1337) as i64;
        for &digit in b.iter() {
            res = Self::pow(res, 10) * Self::pow(a, digit as i64) % 1337;
        }
        res as i32
    }

    fn pow(x: i64, n: i64) -> i64 {
        let mut res: i64 = 1;
        let mut x: i64 = x % 1337;
        let mut n: i64 = n;

        while n > 0 {
            if n % 2 == 1 {
                res = (res * x) % 1337;
            }
            x = (x * x) % 1337;
            n /= 2;
        }

        res
    }
}