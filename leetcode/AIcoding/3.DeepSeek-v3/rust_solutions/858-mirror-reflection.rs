impl Solution {
    pub fn mirror_reflection(p: i32, q: i32) -> i32 {
        let mut m = 1;
        let mut n = 1;
        while m * p != n * q {
            n += 1;
            if m * p < n * q {
                m += 1;
            }
        }
        if m % 2 == 0 && n % 2 == 1 {
            0
        } else if m % 2 == 1 && n % 2 == 1 {
            1
        } else {
            2
        }
    }
}