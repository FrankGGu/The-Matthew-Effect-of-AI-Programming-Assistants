impl Solution {
    pub fn sum_of_total_strength(strength: Vec<i32>) -> i32 {
        let n = strength.len();
        let modulo = 1_000_000_007;

        let mut left = vec![0; n];
        let mut stack = Vec::new();
        for i in 0..n {
            while !stack.is_empty() && strength[*stack.last().unwrap()] >= strength[i] {
                stack.pop();
            }
            left[i] = if stack.is_empty() {
                i as i32 + 1
            } else {
                (i - *stack.last().unwrap()) as i32
            };
            stack.push(i);
        }

        let mut right = vec![0; n];
        stack.clear();
        for i in (0..n).rev() {
            while !stack.is_empty() && strength[*stack.last().unwrap()] > strength[i] {
                stack.pop();
            }
            right[i] = if stack.is_empty() {
                (n - i) as i32
            } else {
                (*stack.last().unwrap() - i) as i32
            };
            stack.push(i);
        }

        let mut prefix_sum = vec![0; n + 1];
        let mut prefix_prefix_sum = vec![0; n + 1];

        for i in 0..n {
            prefix_sum[i + 1] = (prefix_sum[i] + strength[i] as i64) % modulo as i64;
            prefix_prefix_sum[i + 1] = (prefix_prefix_sum[i] + prefix_sum[i + 1]) % modulo as i64;
        }

        let mut ans = 0;
        for i in 0..n {
            let l = i as i32 - left[i] + 1;
            let r = i as i32 + right[i] - 1;

            let left_term = ((i as i64 - l + 1) * prefix_sum[(r + 1) as usize] - (prefix_prefix_sum[(r + 1) as usize] - prefix_prefix_sum[(i + 1) as usize]) + modulo as i64 * 2) % modulo as i64;
            let right_term = ((r - i as i64) * prefix_sum[i as usize] - (prefix_prefix_sum[i as usize] - prefix_prefix_sum[l as usize]) + modulo as i64 * 2) % modulo as i64;

            ans = (ans + strength[i] as i64 * (left_term - right_term + modulo as i64)) % modulo as i64;
            ans = (ans + modulo as i64) % modulo as i64;
        }

        ans as i32
    }
}