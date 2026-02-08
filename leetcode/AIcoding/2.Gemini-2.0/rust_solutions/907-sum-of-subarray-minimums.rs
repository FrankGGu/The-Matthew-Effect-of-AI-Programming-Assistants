impl Solution {
    pub fn sum_subarray_mins(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];
        let mut stack = Vec::new();

        for i in 0..n {
            while !stack.is_empty() && arr[*stack.last().unwrap()] > arr[i] {
                stack.pop();
            }
            left[i] = match stack.last() {
                Some(&j) => i - j,
                None => i + 1,
            };
            stack.push(i);
        }

        stack.clear();
        for i in (0..n).rev() {
            while !stack.is_empty() && arr[*stack.last().unwrap()] >= arr[i] {
                stack.pop();
            }
            right[i] = match stack.last() {
                Some(&j) => j - i,
                None => n - i,
            };
            stack.push(i);
        }

        let mut ans: i64 = 0;
        let modulo: i64 = 1_000_000_007;
        for i in 0..n {
            ans = (ans + (arr[i] as i64) * (left[i] as i64) * (right[i] as i64)) % modulo;
        }

        ans as i32
    }
}