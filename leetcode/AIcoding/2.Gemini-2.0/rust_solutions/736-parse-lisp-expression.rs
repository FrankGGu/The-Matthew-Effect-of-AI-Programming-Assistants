impl Solution {
    pub fn evaluate(expression: String) -> i32 {
        let mut env: Vec<std::collections::HashMap<String, i32>> = vec![std::collections::HashMap::new()];

        fn eval(expression: &str, env: &mut Vec<std::collections::HashMap<String, i32>>) -> i32 {
            let mut tokens = expression.split_whitespace().collect::<Vec<&str>>();

            if tokens[0] == "(" {
                tokens.remove(0);
                let op = tokens.remove(0);

                if op == "let" {
                    env.push(std::collections::HashMap::new());
                    let mut i = 0;
                    while i < tokens.len() - 1 {
                        let var = tokens[i];
                        i += 1;
                        if tokens[i].starts_with("(") {
                            let mut count = 1;
                            let mut j = i + 1;
                            while j < tokens.len() {
                                if tokens[i][tokens[i].len() - 1..] == ")" {

                                }

                                if tokens[j].contains("(") {
                                    count += tokens[j].chars().filter(|&c| c == '(').count();
                                }
                                if tokens[j].contains(")") {
                                    count -= tokens[j].chars().filter(|&c| c == ')').count();
                                }

                                if count == 0 {
                                    break;
                                }
                                j += 1;
                            }
                            let sub_expression = tokens[i..=j].join(" ");
                            let value = eval(&sub_expression, env);
                            env.last_mut().unwrap().insert(var.to_string(), value);
                            i = j + 1;
                        } else {
                            let value = eval(tokens[i], env);
                            env.last_mut().unwrap().insert(var.to_string(), value);
                            i += 1;
                        }
                    }
                    let last_expression = tokens.last().unwrap();
                    let result = eval(last_expression, env);
                    env.pop();
                    result
                } else if op == "add" {
                    let val1 = if tokens[0].starts_with("(") {
                        eval(tokens[0], env)
                    } else {
                        eval(tokens[0], env)
                    };
                    let val2 = if tokens[1].starts_with("(") {
                        eval(tokens[1], env)
                    } else {
                        eval(tokens[1], env)
                    };
                    val1 + val2
                } else if op == "mult" {
                    let val1 = if tokens[0].starts_with("(") {
                        eval(tokens[0], env)
                    } else {
                        eval(tokens[0], env)
                    };
                    let val2 = if tokens[1].starts_with("(") {
                        eval(tokens[1], env)
                    } else {
                        eval(tokens[1], env)
                    };
                    val1 * val2
                } else {
                    0
                }
            } else if expression.chars().all(|c| c.is_digit(10) || c == '-') {
                expression.parse::<i32>().unwrap()
            } else {
                for map in env.iter().rev() {
                    if let Some(&value) = map.get(expression) {
                        return value;
                    }
                }
                0
            }
        }

        eval(&expression, &mut env)
    }
}