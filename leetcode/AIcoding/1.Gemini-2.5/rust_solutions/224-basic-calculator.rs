impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut stack: Vec<(i32, i32)> = Vec::new();
        let mut result: i32 = 0;
        let mut sign: i32 = 1;
        let mut num: i32 = 0;

        for c in s.chars() {
            match c {
                '0'..='9' => {
                    num = num * 10 + (c as i32 - '0' as i32);
                }
                '+' => {
                    result += sign * num;
                    num = 0;
                    sign = 1;
                }
                '-' => {
                    result += sign * num;
                    num = 0;
                    sign = -1;
                }
                '(' => {
                    stack.push((result, sign));
                    result = 0;
                    sign = 1;
                }
                ')' => {
                    result += sign * num;
                    num = 0;

                    let (prev_result, prev_sign) = stack.pop().unwrap();
                    result = prev_result + result * prev_sign;
                }
                _ => {
                    // Ignore spaces
                }
            }
        }

        result += sign * num;
        result
    }
}