impl Solution {
    pub fn count_even(num: i32) -> i32 {
        let mut count = 0;
        for i in 1..=num {
            let mut sum = 0;
            let mut n = i;
            while n > 0 {
                sum += n % 10;
                n /= 10;
            }
            if sum % 2 == 0 {
                count += 1;
            }
        }
        count
    }
}