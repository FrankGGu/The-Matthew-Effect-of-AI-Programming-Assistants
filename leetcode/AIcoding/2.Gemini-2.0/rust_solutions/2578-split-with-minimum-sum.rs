impl Solution {
    pub fn split_num(mut num: i32) -> i32 {
        let mut digits: Vec<i32> = Vec::new();
        while num > 0 {
            digits.push(num % 10);
            num /= 10;
        }
        digits.sort();
        let mut num1: i32 = 0;
        let mut num2: i32 = 0;
        for i in 0..digits.len() {
            if i % 2 == 0 {
                num1 = num1 * 10 + digits[i];
            } else {
                num2 = num2 * 10 + digits[i];
            }
        }
        num1 + num2
    }
}