pub fn validate_stack_sequences(pushed: Vec<i32>, popped: Vec<i32>) -> bool {
    let mut stack = Vec::new();
    let mut j = 0;

    for &num in &pushed {
        stack.push(num);
        while !stack.is_empty() && stack.last() == Some(&popped[j]) {
            stack.pop();
            j += 1;
        }
    }

    stack.is_empty()
}