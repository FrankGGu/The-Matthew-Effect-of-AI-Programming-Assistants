struct Solution;

impl Solution {
    pub fn validate_stack_sequences(pushed: Vec<i32>, popped: Vec<i32>) -> bool {
        let mut stack: Vec<i32> = Vec::new();
        let mut popped_idx = 0;

        for &num in pushed.iter() {
            stack.push(num);
            while let Some(&top) = stack.last() {
                if popped_idx < popped.len() && top == popped[popped_idx] {
                    stack.pop();
                    popped_idx += 1;
                } else {
                    break;
                }
            }
        }

        stack.is_empty()
    }
}