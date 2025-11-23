use std::collections::HashMap;

pub fn evaluate(expression: String) -> i32 {
    let mut vars = HashMap::new();
    evaluate_inner(&expression, &mut vars)
}

fn evaluate_inner(expression: &str, vars: &mut HashMap<String, i32>) -> i32 {
    if expression.starts_with('(') {
        let mut stack = vec![];
        let mut cmd = String::new();
        let mut current = String::new();
        let mut i = 1;

        while i < expression.len() {
            match &expression[i..i + 1] {
                "(" => {
                    stack.push(current);
                    current = String::new();
                }
                ")" => {
                    let last_cmd = stack.pop().unwrap();
                    let result = if last_cmd == "let" {
                        let var = current.split_whitespace().next().unwrap().to_string();
                        let value = evaluate_inner(&format!("({})", current.split_whitespace().skip(1).collect::<Vec<&str>>().join(" ")), vars);
                        vars.insert(var, value);
                        value
                    } else if last_cmd == "add" {
                        let args: Vec<i32> = current.split_whitespace().map(|x| evaluate_inner(x, vars)).collect();
                        args.iter().sum()
                    } else if last_cmd == "mult" {
                        let args: Vec<i32> = current.split_whitespace().map(|x| evaluate_inner(x, vars)).collect();
                        args.iter().product()
                    } else {
                        0
                    };
                    return result;
                }
                " " => {
                    if !current.is_empty() {
                        if cmd.is_empty() {
                            cmd = current.clone();
                        } else {
                            if !stack.is_empty() {
                                current.push_str(" ");
                            }
                            current.push_str(&current);
                        }
                        current.clear();
                    }
                }
                _ => current.push_str(&expression[i..i + 1]),
            }
            i += 1;
        }
    } else if expression.chars().all(|c| c.is_digit(10) || c == '-') {
        expression.parse::<i32>().unwrap()
    } else {
        *vars.get(expression).unwrap()
    }
}