impl Solution {
    pub fn minimum_sum(num: i32) -> i32 {
        let mut digits: Vec<i32> = Vec::new();
        let mut n = num;
        while n > 0 {
            digits.push(n % 10);
            n /= 10;
        }
        digits.sort();
        (digits[0] + digits[1]) * 10 + digits[2] + digits[3]
    }
}