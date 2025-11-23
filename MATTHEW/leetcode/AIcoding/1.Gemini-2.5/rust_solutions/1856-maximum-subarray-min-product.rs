impl Solution {
    pub fn max_subarray_min_product(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut left: Vec<usize> = vec![0; n];
        let mut stack: Vec<usize> = Vec::new();
        for i in 0..n {
            while let Some(&top_idx) = stack.last() {
                if nums[top_idx] >= nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            left[i] = if let Some(&top_idx) = stack.last() { top_idx } else { usize::MAX };
            stack.push(i);
        }

        let mut right: Vec<usize> = vec![0; n];
        stack.clear();
        for i in (0..n).rev() {
            while let Some(&top_idx) = stack.last() {
                if nums[top_idx] >= nums[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            right[i] = if let Some(&top_idx) = stack.last() { top_idx } else { n };
            stack.push(i);
        }

        let mut max_product: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for i in 0..n {
            let start_idx = if left[i] == usize::MAX { 0 } else { left[i] + 1 };
            let end_idx = right[i];

            let current_subarray_sum = prefix_sum[end_idx] - prefix_sum[start_idx];
            let current_product = nums[i] as i64 * current_subarray_sum;
            max_product = max_product.max(current_product);
        }

        (max_product % modulo) as i32
    }
}