impl Solution {
    pub fn max_sum_min_product(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];
        let mut stack = Vec::new();

        for i in 0..n {
            while !stack.is_empty() && nums[*stack.last().unwrap()] >= nums[i] {
                stack.pop();
            }
            left[i] = match stack.last() {
                Some(&j) => j as i32 + 1,
                None => 0,
            };
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while !stack.is_empty() && nums[*stack.last().unwrap()] > nums[i] {
                stack.pop();
            }
            right[i] = match stack.last() {
                Some(&j) => j as i32 - 1,
                None => (n - 1) as i32,
            };
            stack.push(i);
        }

        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut max_product = 0;
        for i in 0..n {
            let sum = prefix_sum[right[i] as usize + 1] - prefix_sum[left[i] as usize];
            max_product = std::cmp::max(max_product, sum * nums[i] as i64);
        }

        (max_product % 1000000007) as i32
    }
}