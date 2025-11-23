struct Solution;

impl Solution {
    pub fn parse_bool_expr(s: String) -> bool {
        let mut stack = vec![];
        let chars: Vec<char> = s.chars().collect();
        let mut i = 0;

        while i < chars.len() {
            match chars[i] {
                '!' | '&' | '|' => {
                    let op = chars[i];
                    i += 2; // skip operator and '('
                    let mut exprs = vec![];
                    let mut depth = 1;
                    let mut current = vec![];

                    while depth > 0 {
                        if chars[i] == '(' {
                            depth += 1;
                        } else if chars[i] == ')' {
                            depth -= 1;
                        }

                        if depth > 0 {
                            current.push(chars[i]);
                        }

                        i += 1;
                    }

                    let expr = current.into_iter().collect::<String>();
                    let result = match op {
                        '!' => !Self::parse_bool_expr(expr),
                        '&' => {
                            let mut res = true;
                            for c in expr.chars() {
                                if c == ',' {
                                    continue;
                                }
                                res &= Self::parse_bool_expr(c.to_string());
                                if !res {
                                    break;
                                }
                            }
                            res
                        },
                        '|' => {
                            let mut res = false;
                            for c in expr.chars() {
                                if c == ',' {
                                    continue;
                                }
                                res |= Self::parse_bool_expr(c.to_string());
                                if res {
                                    break;
                                }
                            }
                            res
                        },
                        _ => false,
                    };

                    stack.push(result);
                },
                't' => {
                    stack.push(true);
                    i += 1;
                },
                'f' => {
                    stack.push(false);
                    i += 1;
                },
                _ => i += 1,
            }
        }

        stack.pop().unwrap()
    }
}