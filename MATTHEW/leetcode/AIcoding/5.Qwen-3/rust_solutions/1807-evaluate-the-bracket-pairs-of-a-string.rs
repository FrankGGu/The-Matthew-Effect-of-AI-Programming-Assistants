impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn evaluate(equation: String) -> String {
        let mut stack = vec![];
        let mut variables = HashMap::new();
        let mut current_var = String::new();
        let mut current_value = String::new();
        let mut in_var = false;
        let mut in_value = false;

        for c in equation.chars() {
            match c {
                '(' => {
                    if in_var {
                        stack.push((current_var, current_value));
                        current_var = String::new();
                        current_value = String::new();
                        in_var = false;
                        in_value = false;
                    } else {
                        stack.push(("", current_value));
                        current_value = String::new();
                    }
                },
                ')' => {
                    if in_var {
                        let value = variables.get(&current_var).cloned().unwrap_or(current_var.clone());
                        current_value.push_str(&value);
                        current_var = String::new();
                        in_var = false;
                    }
                    let (var, prev_value) = stack.pop().unwrap();
                    if var.is_empty() {
                        current_value = prev_value + &current_value;
                    } else {
                        variables.insert(var.to_string(), current_value.clone());
                    }
                },
                ':' => {
                    in_var = true;
                    in_value = false;
                },
                _ => {
                    if in_var {
                        current_var.push(c);
                    } else if in_value {
                        current_value.push(c);
                    } else {
                        current_value.push(c);
                    }
                }
            }
        }

        current_value
    }
}
}