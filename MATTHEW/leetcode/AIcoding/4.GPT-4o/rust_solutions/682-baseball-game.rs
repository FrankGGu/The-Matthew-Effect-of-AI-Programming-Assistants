impl Solution {
    pub fn cal_points(ops: Vec<String>) -> i32 {
        let mut stack = Vec::new();
        for op in ops {
            match op.as_str() {
                "C" => { stack.pop(); },
                "D" => { if let Some(&last) = stack.last() { stack.push(2 * last); } },
                "+" => { 
                    let sum = stack.iter().rev().take(2).sum::<i32>();
                    stack.push(sum);
                },
                _ => { 
                    if let Ok(num) = op.parse::<i32>() {
                        stack.push(num);
                    }
                }
            }
        }
        stack.iter().sum()
    }
}