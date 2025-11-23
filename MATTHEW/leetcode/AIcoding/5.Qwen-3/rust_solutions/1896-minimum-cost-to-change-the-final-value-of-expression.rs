impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_cost(expression: String) -> i32 {
        fn parse_expression(expr: &str, cost: &[i32; 2]) -> (i32, i32, HashMap<char, i32>) {
            let mut stack = vec![];
            let mut tokens = expr.chars().filter(|c| !c.is_whitespace()).peekable();

            while let Some(c) = tokens.next() {
                if c == '(' {
                    let (val, cost_val, vars) = parse_expression(&expr[tokens.peek().unwrap()..], cost);
                    stack.push((val, cost_val, vars));
                } else if c == ')' {
                    break;
                } else if c == '0' || c == '1' {
                    stack.push((c as i32 - '0' as i32, 0, HashMap::new()));
                } else if c == '!' {
                    let (val, cost_val, vars) = stack.pop().unwrap();
                    stack.push((1 - val, cost_val + cost[1], vars));
                } else if c == '&' || c == '|' {
                    let (val1, cost1, vars1) = stack.pop().unwrap();
                    let (val2, cost2, vars2) = stack.pop().unwrap();
                    let mut new_vars = vars1;
                    for (k, v) in &vars2 {
                        new_vars.entry(*k).or_insert(*v);
                    }
                    let val = if c == '&' { val1 & val2 } else { val1 | val2 };
                    let cost_val = cost1 + cost2 + cost[0];
                    stack.push((val, cost_val, new_vars));
                } else {
                    let mut var = c;
                    let mut next = tokens.next();
                    while next.is_some() && next.unwrap().is_digit(10) {
                        var = next.unwrap();
                        next = tokens.next();
                    }
                    stack.push((0, 0, vec![(var, 0)].into_iter().collect()));
                }
            }

            let (val, cost_val, vars) = stack.pop().unwrap();
            (val, cost_val, vars)
        }

        let cost = [1, 1];
        let (_, total_cost, _) = parse_expression(&expression, &cost);
        total_cost
    }
}
}