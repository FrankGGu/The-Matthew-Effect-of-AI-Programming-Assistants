impl Solution {
    pub fn trailing_zeroes(n: i32) -> i32 {
        let mut count = 0;
        let mut power_of_5 = 5;
        while n >= power_of_5 {
            count += n / power_of_5;
            if power_of_5 > n / 5 { // Avoid overflow for power_of_5 * 5
                break;
            }
            power_of_5 *= 5;
        }
        count
    }
}