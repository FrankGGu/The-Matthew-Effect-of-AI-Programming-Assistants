impl Solution {
    pub fn cal_points(operations: Vec<String>) -> i32 {
        let mut stack = Vec::new();
        for op in operations {
            match op.as_str() {
                "+" => {
                    let sum = stack[stack.len() - 1] + stack[stack.len() - 2];
                    stack.push(sum);
                },
                "D" => {
                    let double = 2 * stack[stack.len() - 1];
                    stack.push(double);
                },
                "C" => {
                    stack.pop();
                },
                _ => {
                    stack.push(op.parse::<i32>().unwrap());
                }
            }
        }
        stack.iter().sum()
    }
}