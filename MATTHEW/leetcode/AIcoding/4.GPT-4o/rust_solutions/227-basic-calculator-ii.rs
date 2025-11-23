pub fn calculate(s: String) -> i32 {
    let mut stack: Vec<i32> = Vec::new();
    let mut current_num = 0;
    let mut last_op = '+'; 

    for (i, c) in s.chars().chain(std::iter::once(' ')).enumerate() {
        if c.is_digit(10) {
            current_num = current_num * 10 + c.to_digit(10).unwrap() as i32;
        } else if !c.is_whitespace() {
            match last_op {
                '+' => stack.push(current_num),
                '-' => stack.push(-current_num),
                '*' => {
                    let top = stack.pop().unwrap();
                    stack.push(top * current_num);
                }
                '/' => {
                    let top = stack.pop().unwrap();
                    stack.push(top / current_num);
                }
            }
            last_op = c;
            current_num = 0;
        }
    }

    stack.iter().sum()
}