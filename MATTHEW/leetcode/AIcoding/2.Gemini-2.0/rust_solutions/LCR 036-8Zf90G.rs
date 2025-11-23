impl Solution {
    pub fn eval_rpn(tokens: Vec<String>) -> i32 {
        let mut stack: Vec<i32> = Vec::new();
        for token in tokens {
            match token.as_str() {
                "+" => {
                    let op2 = stack.pop().unwrap();
                    let op1 = stack.pop().unwrap();
                    stack.push(op1 + op2);
                }
                "-" => {
                    let op2 = stack.pop().unwrap();
                    let op1 = stack.pop().unwrap();
                    stack.push(op1 - op2);
                }
                "*" => {
                    let op2 = stack.pop().unwrap();
                    let op1 = stack.pop().unwrap();
                    stack.push(op1 * op2);
                }
                "/" => {
                    let op2 = stack.pop().unwrap();
                    let op1 = stack.pop().unwrap();
                    stack.push(op1 / op2);
                }
                _ => {
                    stack.push(token.parse::<i32>().unwrap());
                }
            }
        }
        stack.pop().unwrap()
    }
}