struct Solution;

impl Solution {
    pub fn minimum_operations(num: i32) -> i32 {
        if num == 0 {
            return 0;
        }
        let mut n = num;
        let mut count = 0;
        while n > 0 {
            if n % 10 == 0 {
                n /= 10;
            } else {
                n -= 1;
            }
            count += 1;
        }
        count
    }
}