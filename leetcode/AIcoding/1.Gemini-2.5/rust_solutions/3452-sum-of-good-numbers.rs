struct Solution;

impl Solution {
    fn sum_digits(mut num: i32) -> i32 {
        let mut sum = 0;
        while num > 0 {
            sum += num % 10;
            num /= 10;
        }
        sum
    }

    pub fn sum_of_good_numbers(n: i32) -> i32 {
        let mut total_sum = 0;
        for i in 1..=n {
            if Self::sum_digits(i) % 2 == 0 {
                total_sum += i;
            }
        }
        total_sum
    }
}