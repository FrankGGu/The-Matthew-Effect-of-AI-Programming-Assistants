impl Solution {
    pub fn pivot_integer(n: i32) -> i32 {
        let total_sum: i32 = (1..=n).sum();
        let mut left_sum = 0;

        for i in 1..=n {
            left_sum += i;
            if left_sum * left_sum == total_sum {
                return i;
            }
        }
        -1
    }
}