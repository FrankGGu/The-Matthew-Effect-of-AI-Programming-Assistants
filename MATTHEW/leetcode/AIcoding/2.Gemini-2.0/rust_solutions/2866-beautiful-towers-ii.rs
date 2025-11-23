impl Solution {
    pub fn maximum_sum_of_heights(max_heights: Vec<i32>) -> i64 {
        let n = max_heights.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];
        let mut stack = Vec::new();

        for i in 0..n {
            while !stack.is_empty() && max_heights[*stack.last().unwrap()] >= max_heights[i] {
                stack.pop();
            }
            if stack.is_empty() {
                left[i] = (i as i64 + 1) * max_heights[i] as i64;
            } else {
                left[i] = left[*stack.last().unwrap()] + (i as i64 - *stack.last().unwrap() as i64) * max_heights[i] as i64;
            }
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while !stack.is_empty() && max_heights[*stack.last().unwrap()] >= max_heights[i] {
                stack.pop();
            }
            if stack.is_empty() {
                right[i] = (n as i64 - i as i64) * max_heights[i] as i64;
            } else {
                right[i] = right[*stack.last().unwrap()] + (*stack.last().unwrap() as i64 - i as i64) * max_heights[i] as i64;
            }
            stack.push(i);
        }

        let mut ans = 0;
        for i in 0..n {
            ans = ans.max(left[i] + right[i] - max_heights[i] as i64);
        }

        ans
    }
}