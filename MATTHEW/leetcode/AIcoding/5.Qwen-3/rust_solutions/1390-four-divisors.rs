struct Solution;

impl Solution {
    pub fn sum_of_divisors(n: i32) -> i32 {
        let mut sum = 0;
        let mut count = 0;
        for i in 1..=n {
            if n % i == 0 {
                count += 1;
                sum += i;
            }
        }
        if count == 4 {
            sum
        } else {
            0
        }
    }
}