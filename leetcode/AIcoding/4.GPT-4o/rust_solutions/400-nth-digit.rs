impl Solution {
    pub fn find_nth_digit(n: i32) -> i32 {
        let mut n = n as i64;
        let mut digit_length = 1;
        let mut count = 9;
        let mut start = 1;

        while n > digit_length * count {
            n -= digit_length * count;
            digit_length += 1;
            count *= 10;
            start *= 10;
        }

        start += (n - 1) / digit_length;
        let s = start.to_string();
        let index = (n - 1) % digit_length;

        s.chars().nth(index as usize).unwrap().to_digit(10).unwrap() as i32
    }
}