impl Solution {
    pub fn cal_points(operations: Vec<String>) -> i32 {
        let mut stack: Vec<i32> = Vec::new();
        for op in operations {
            match op.as_str() {
                "+" => {
                    let val1 = stack.pop().unwrap();
                    let val2 = stack.last().unwrap();
                    stack.push(val1);
                    stack.push(val1 + val2);
                }
                "D" => {
                    let val = stack.last().unwrap();
                    stack.push(val * 2);
                }
                "C" => {
                    stack.pop();
                }
                _ => {
                    stack.push(op.parse::<i32>().unwrap());
                }
            }
        }
        stack.iter().sum()
    }
}