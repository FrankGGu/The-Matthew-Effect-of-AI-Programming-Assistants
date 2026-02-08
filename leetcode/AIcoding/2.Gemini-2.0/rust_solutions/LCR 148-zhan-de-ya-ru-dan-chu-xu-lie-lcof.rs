impl Solution {
    pub fn validate_stack_sequences(pushed: Vec<i32>, popped: Vec<i32>) -> bool {
        let mut stack: Vec<i32> = Vec::new();
        let mut i = 0;
        for &push_val in &pushed {
            stack.push(push_val);
            while !stack.is_empty() && i < popped.len() && stack.last().copied() == Some(popped[i]) {
                stack.pop();
                i += 1;
            }
        }
        stack.is_empty()
    }
}