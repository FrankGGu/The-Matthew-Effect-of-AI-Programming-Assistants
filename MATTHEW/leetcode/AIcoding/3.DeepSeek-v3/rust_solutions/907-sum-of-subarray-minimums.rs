impl Solution {
    pub fn sum_subarray_mins(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut left = vec![-1; n];
        let mut right = vec![n as i32; n];
        let mut stack: Vec<usize> = Vec::new();

        for i in 0..n {
            while !stack.is_empty() && arr[*stack.last().unwrap()] >= arr[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                left[i] = *stack.last().unwrap() as i32;
            }
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while !stack.is_empty() && arr[*stack.last().unwrap()] > arr[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                right[i] = *stack.last().unwrap() as i32;
            }
            stack.push(i);
        }

        let mut res = 0;
        let modulo = 1_000_000_007;

        for i in 0..n {
            res += ((i as i32 - left[i]) * (right[i] - i as i32) % modulo) as i64 * arr[i] as i64 % modulo;
            res %= modulo;
        }

        res as i32
    }
}