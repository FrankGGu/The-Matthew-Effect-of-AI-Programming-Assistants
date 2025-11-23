impl Solution {
    pub fn mirror_reflection(p: i32, q: i32) -> i32 {
        let mut m = 1;
        let mut n = 1;
        while m * p != n * q {
            m += 1;
            n = m * p / q;
        }
        if m % 2 == 0 {
            return 2;
        }
        if n % 2 == 0 {
            return 0;
        }
        return 1;
    }
}