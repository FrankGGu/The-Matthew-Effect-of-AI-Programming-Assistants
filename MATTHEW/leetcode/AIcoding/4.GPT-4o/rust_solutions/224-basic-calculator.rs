pub fn calculate(s: String) -> i32 {
    let mut stack = vec![];
    let mut current_number = 0;
    let mut result = 0;
    let mut sign = 1;

    for c in s.chars() {
        if c.is_digit(10) {
            current_number = current_number * 10 + c.to_digit(10).unwrap() as i32;
        } else if c == '+' {
            result += sign * current_number;
            current_number = 0;
            sign = 1;
        } else if c == '-' {
            result += sign * current_number;
            current_number = 0;
            sign = -1;
        } else if c == '(' {
            stack.push(result);
            stack.push(sign);
            result = 0;
            sign = 1;
        } else if c == ')' {
            result += sign * current_number;
            current_number = 0;
            result *= stack.pop().unwrap(); // sign before the parenthesis
            result += stack.pop().unwrap(); // result calculated before the parenthesis
        }
    }

    result + sign * current_number
}