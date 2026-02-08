impl Solution {
    pub fn sum_multiples(n: i32) -> i32 {
        let mut sum = 0;
        for i in 1..=n {
            if i % 3 == 0 || i % 5 == 0 || i % 7 == 0 {
                sum += i;
            }
        }
        sum
    }
}