impl Solution {
    pub fn maximum_beautiful_towers(max_heights: Vec<i32>) -> i64 {
        let n = max_heights.len();
        let mut left_sums = vec![0i64; n];
        let mut stack: Vec<usize> = Vec::new(); // Stores indices

        for i in 0..n {
            let h = max_heights[i] as i64;
            while !stack.is_empty() && max_heights[*stack.last().unwrap()] as i64 >= h {
                stack.pop();
            }
            let prev_idx = if stack.is_empty() { -1 } else { *stack.last().unwrap() as isize };
            let prev_sum = if prev_idx != -1 { left_sums[prev_idx as usize] } else { 0 };
            left_sums[i] = prev_sum + h * ((i as isize - prev_idx) as i64);
            stack.push(i);
        }

        let mut right_sums = vec![0i64; n];
        stack.clear();

        for i in (0..n).rev() {
            let h = max_heights[i] as i64;
            while !stack.is_empty() && max_heights[*stack.last().unwrap()] as i64 >= h {
                stack.pop();
            }
            let next_idx = if stack.is_empty() { n } else { *stack.last().unwrap() };
            let next_sum = if next_idx != n { right_sums[next_idx] } else { 0 };
            right_sums[i] = next_sum + h * ((next_idx - i) as i64);
            stack.push(i);
        }

        let mut max_total_sum = 0i64;
        for i in 0..n {
            max_total_sum = max_total_sum.max(left_sums[i] + right_sums[i] - max_heights[i] as i64);
        }

        max_total_sum
    }
}