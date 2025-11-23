struct Solution;

impl Solution {
    pub fn validate_stack_sequences(pushed: Vec<i32>, popped: Vec<i32>) -> bool {
        let mut stack = Vec::new();
        let mut i = 0;
        for &val in &pushed {
            stack.push(val);
            while stack.last() == Some(&popped[i]) {
                stack.pop();
                i += 1;
            }
        }
        i == popped.len()
    }
}