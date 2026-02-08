impl Solution {
    pub fn find_nth_digit(n: i32) -> i32 {
        let mut n = n as i64;
        let mut digits = 1;
        let mut count = 9;

        while n > digits * count {
            n -= digits * count;
            digits += 1;
            count *= 10;
        }

        let num = 10_i64.pow(digits as u32) + (n - 1) / digits - 1;
        let index = (n - 1) % digits;

        let s = (num + 1).to_string();
        let c = s.chars().nth(index as usize).unwrap();
        c.to_digit(10).unwrap() as i32
    }
}