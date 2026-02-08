impl Solution {
    pub fn trailing_zeroes(n: i32) -> i32 {
        let mut count = 0;
        let mut n = n;
        while n > 0 {
            n /= 5;
            count += n;
        }
        count
    }
}