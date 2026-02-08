impl Solution {
    pub fn split_num(num: i32) -> i32 {
        let mut digits: Vec<char> = num.to_string().chars().collect();
        digits.sort();

        let mut num1 = 0;
        let mut num2 = 0;

        for (i, &ch) in digits.iter().enumerate() {
            let digit = ch.to_digit(10).unwrap() as i32;
            if i % 2 == 0 {
                num1 = num1 * 10 + digit;
            } else {
                num2 = num2 * 10 + digit;
            }
        }

        num1 + num2
    }
}