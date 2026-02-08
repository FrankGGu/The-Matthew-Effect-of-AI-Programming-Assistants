impl Solution {
    pub fn is_ugly(n: i32) -> bool {
        if n <= 0 {
            return false;
        }
        let mut num = n;
        for p in [2, 3, 5].iter() {
            while num % p == 0 {
                num /= p;
            }
        }
        num == 1
    }
}