impl Solution {
    pub fn is_ugly(n: i32) -> bool {
        if n <= 0 {
            return false;
        }
        let mut num = n;
        let factors = [2, 3, 5];
        for factor in factors {
            while num % factor == 0 {
                num /= factor;
            }
        }
        num == 1
    }
}