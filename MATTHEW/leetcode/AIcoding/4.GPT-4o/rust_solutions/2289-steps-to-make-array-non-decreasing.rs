pub fn total_steps(arr: Vec<i32>) -> Vec<i32> {
    let n = arr.len();
    let mut stack = Vec::new();
    let mut result = vec![0; n];

    for i in 0..n {
        let mut max_steps = 0;
        while let Some(&j) = stack.last() {
            if arr[j] <= arr[i] {
                max_steps = max_steps.max(result[j]);
                stack.pop();
            } else {
                break;
            }
        }
        if !stack.is_empty() {
            result[i] = max_steps + 1;
        }
        stack.push(i);
    }

    result
}