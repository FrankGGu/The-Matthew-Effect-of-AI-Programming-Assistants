pub fn parse_bool_expr(expression: String) -> bool {
    fn eval(expr: &str) -> (bool, usize) {
        match expr.chars().next().unwrap() {
            't' => (true, 1),
            'f' => (false, 1),
            '!' => {
                let (val, consumed) = eval(&expr[2..]);
                ( !val, consumed + 2)
            },
            '&' => {
                let mut i = 2;
                let mut result = true;
                while i < expr.len() {
                    let (val, consumed) = eval(&expr[i..]);
                    result &= val;
                    i += consumed;
                    if i < expr.len() && expr.chars().nth(i).unwrap() == ')' {
                        break;
                    }
                }
                (result, i + 1)
            },
            '|' => {
                let mut i = 2;
                let mut result = false;
                while i < expr.len() {
                    let (val, consumed) = eval(&expr[i..]);
                    result |= val;
                    i += consumed;
                    if i < expr.len() && expr.chars().nth(i).unwrap() == ')' {
                        break;
                    }
                }
                (result, i + 1)
            },
            _ => unreachable!(),
        }
    }
    eval(&expression).0
}