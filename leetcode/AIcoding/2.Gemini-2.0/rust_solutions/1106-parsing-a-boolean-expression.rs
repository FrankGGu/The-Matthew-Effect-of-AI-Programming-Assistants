impl Solution {
    pub fn parse_bool_expr(expression: String) -> bool {
        let mut stack: Vec<char> = Vec::new();
        for c in expression.chars() {
            match c {
                ')' => {
                    let mut t_count = 0;
                    let mut f_count = 0;
                    while let Some(top) = stack.pop() {
                        if top == '(' {
                            break;
                        } else if top == 't' {
                            t_count += 1;
                        } else if top == 'f' {
                            f_count += 1;
                        }
                    }
                    let op = stack.pop().unwrap();
                    match op {
                        '&' => {
                            if f_count > 0 {
                                stack.push('f');
                            } else {
                                stack.push('t');
                            }
                        }
                        '|' => {
                            if t_count > 0 {
                                stack.push('t');
                            } else {
                                stack.push('f');
                            }
                        }
                        '!' => {
                            if t_count > 0 {
                                stack.push('f');
                            } else {
                                stack.push('t');
                            }
                        }
                        _ => {}
                    }
                }
                ',' => {}
                _ => {
                    stack.push(c);
                }
            }
        }
        if let Some(result) = stack.pop() {
            return result == 't';
        }
        false
    }
}