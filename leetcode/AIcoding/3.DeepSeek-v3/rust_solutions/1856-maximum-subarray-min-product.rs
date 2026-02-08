impl Solution {
    pub fn max_sum_min_product(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i] as i64;
        }

        let mut left = vec![0; n];
        let mut right = vec![n; n];
        let mut stack: Vec<usize> = Vec::new();

        for i in 0..n {
            while !stack.is_empty() && nums[*stack.last().unwrap()] >= nums[i] {
                stack.pop();
            }
            left[i] = if stack.is_empty() { 0 } else { stack.last().unwrap() + 1 };
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while !stack.is_empty() && nums[*stack.last().unwrap()] >= nums[i] {
                stack.pop();
            }
            right[i] = if stack.is_empty() { n } else { *stack.last().unwrap() };
            stack.push(i);
        }

        let mut max = 0;
        for i in 0..n {
            let sum = prefix[right[i]] - prefix[left[i]];
            let product = nums[i] as i64 * sum;
            if product > max {
                max = product;
            }
        }

        (max % (10_i64.pow(9) + 7)) as i32
    }
}