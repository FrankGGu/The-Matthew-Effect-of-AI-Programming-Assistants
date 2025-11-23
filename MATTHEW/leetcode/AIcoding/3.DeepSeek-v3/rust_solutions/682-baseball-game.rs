impl Solution {
    pub fn cal_points(operations: Vec<String>) -> i32 {
        let mut stack = Vec::new();

        for op in operations {
            match op.as_str() {
                "+" => {
                    let last = stack[stack.len() - 1];
                    let second_last = stack[stack.len() - 2];
                    stack.push(last + second_last);
                },
                "D" => {
                    let last = stack[stack.len() - 1];
                    stack.push(last * 2);
                },
                "C" => {
                    stack.pop();
                },
                _ => {
                    let num = op.parse::<i32>().unwrap();
                    stack.push(num);
                }
            }
        }

        stack.iter().sum()
    }
}