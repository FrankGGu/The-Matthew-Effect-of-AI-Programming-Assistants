impl Solution {
    pub fn is_ugly(num: i32) -> bool {
        if num <= 0 {
            return false;
        }
        let mut n = num;
        while n % 2 == 0 {
            n /= 2;
        }
        while n % 3 == 0 {
            n /= 3;
        }
        while n % 5 == 0 {
            n /= 5;
        }
        n == 1
    }
}