struct Solution {}

impl Solution {
    pub fn find_nth_digit(n: i32) -> i32 {
        let mut n = n;
        let mut digits = 1;
        let mut count = 9;
        let mut start = 1;

        while n > digits * count {
            n -= digits * count;
            digits += 1;
            count *= 10;
            start *= 10;
        }

        let number = start + (n - 1) / digits;
        let index = (n - 1) % digits;
        (number.to_string().chars().nth(index).unwrap() as u8 - b'0') as i32
    }
}