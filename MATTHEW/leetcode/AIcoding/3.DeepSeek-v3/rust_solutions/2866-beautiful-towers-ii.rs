impl Solution {
    pub fn maximum_sum_of_heights(max_heights: Vec<i32>) -> i64 {
        let n = max_heights.len();
        let mut left = vec![0; n];
        let mut stack: Vec<usize> = Vec::new();
        let mut sum = 0i64;

        for i in 0..n {
            while !stack.is_empty() && max_heights[*stack.last().unwrap()] > max_heights[i] {
                stack.pop();
            }
            if stack.is_empty() {
                sum = max_heights[i] as i64 * (i + 1) as i64;
            } else {
                let last = *stack.last().unwrap();
                sum = left[last] + max_heights[i] as i64 * (i - last) as i64;
            }
            left[i] = sum;
            stack.push(i);
        }

        let mut right = vec![0; n];
        stack.clear();
        sum = 0;
        let mut res = 0i64;

        for i in (0..n).rev() {
            while !stack.is_empty() && max_heights[*stack.last().unwrap()] > max_heights[i] {
                stack.pop();
            }
            if stack.is_empty() {
                sum = max_heights[i] as i64 * (n - i) as i64;
            } else {
                let last = *stack.last().unwrap();
                sum = right[last] + max_heights[i] as i64 * (last - i) as i64;
            }
            right[i] = sum;
            stack.push(i);
            res = res.max(left[i] + right[i] - max_heights[i] as i64);
        }

        res
    }
}