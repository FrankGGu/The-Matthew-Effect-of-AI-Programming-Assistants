struct Solution;

impl Solution {
    pub fn pivot_integer(x: i32) -> i32 {
        let mut total = 0;
        for i in 1..=x {
            total += i;
        }
        let mut sum = 0;
        for i in 1..=x {
            sum += i;
            if sum == total - sum + i {
                return i;
            }
        }
        -1
    }
}