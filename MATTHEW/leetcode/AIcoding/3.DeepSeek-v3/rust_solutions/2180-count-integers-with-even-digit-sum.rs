impl Solution {
    pub fn count_even(num: i32) -> i32 {
        (1..=num).filter(|&x| {
            let mut sum = 0;
            let mut n = x;
            while n > 0 {
                sum += n % 10;
                n /= 10;
            }
            sum % 2 == 0
        }).count() as i32
    }
}