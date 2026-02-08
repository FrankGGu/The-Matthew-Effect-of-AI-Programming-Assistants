pub fn sum_subarray_minimums(arr: Vec<i32>) -> i32 {
    let mut stack = Vec::new();
    let mut sum = 0;
    let mut mod_val = 1_000_000_007;
    let n = arr.len();
    let mut left = vec![0; n];
    let mut right = vec![0; n];

    for i in 0..n {
        while !stack.is_empty() && arr[stack.last().unwrap()] > arr[i] {
            stack.pop();
        }
        left[i] = if stack.is_empty() { i + 1 } else { i - stack.last().unwrap() };
        stack.push(i);
    }

    stack.clear();

    for i in (0..n).rev() {
        while !stack.is_empty() && arr[stack.last().unwrap()] >= arr[i] {
            stack.pop();
        }
        right[i] = if stack.is_empty() { n - i } else { stack.last().unwrap() - i };
        stack.push(i);
    }

    for i in 0..n {
        sum = (sum + arr[i] as i64 * left[i] as i64 * right[i] as i64) % mod_val;
    }

    sum as i32
}