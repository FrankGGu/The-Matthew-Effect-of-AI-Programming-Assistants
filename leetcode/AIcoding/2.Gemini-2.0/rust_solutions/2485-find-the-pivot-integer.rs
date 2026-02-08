impl Solution {
    pub fn pivot_integer(n: i32) -> i32 {
        let sum: i32 = (1 + n) * n / 2;
        let mut left_sum: i32 = 0;
        for i in 1..=n {
            left_sum += i;
            if left_sum * 2 == sum + i {
                return i;
            }
        }
        -1
    }
}