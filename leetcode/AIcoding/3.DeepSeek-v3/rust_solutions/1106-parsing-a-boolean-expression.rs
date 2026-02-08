impl Solution {
    pub fn parse_bool_expr(expression: String) -> bool {
        let mut stack: Vec<char> = Vec::new();
        for c in expression.chars() {
            if c == ',' {
                continue;
            }
            if c != ')' {
                stack.push(c);
            } else {
                let mut args = Vec::new();
                while let Some(top) = stack.pop() {
                    if top == '(' {
                        break;
                    }
                    args.push(top);
                }
                let op = stack.pop().unwrap();
                let res = match op {
                    '&' => args.iter().all(|&x| x == 't'),
                    '|' => args.iter().any(|&x| x == 't'),
                    '!' => args[0] != 't',
                    _ => unreachable!(),
                };
                stack.push(if res { 't' } else { 'f' });
            }
        }
        stack.pop().unwrap() == 't'
    }
}