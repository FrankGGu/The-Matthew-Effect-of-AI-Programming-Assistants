impl Solution {
    pub fn trailing_zeroes(n: i32) -> i32 {
        let mut count = 0;
        let mut k = 5;
        while k <= n {
            count += n / k;
            if k > i32::MAX / 5 {
                break;
            }
            k *= 5;
        }
        count
    }
}