impl Solution {
    pub fn split_num(num: i32) -> i32 {
        let mut digits = Vec::new();
        let mut temp_num = num;

        while temp_num > 0 {
            digits.push(temp_num % 10);
            temp_num /= 10;
        }

        digits.sort_unstable();

        let num1 = digits[0] * 10 + digits[2];
        let num2 = digits[1] * 10 + digits[3];

        num1 + num2
    }
}