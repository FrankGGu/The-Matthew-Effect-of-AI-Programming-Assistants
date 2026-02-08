pub fn max_sum_min_product(nums: Vec<i32>) -> i32 {
    use std::cmp::max;
    let n = nums.len();
    let mut prefix_sum = vec![0; n + 1];
    for i in 0..n {
        prefix_sum[i + 1] = prefix_sum[i] + nums[i];
    }

    let mut stack = Vec::new();
    let mut max_product = 0;

    for i in 0..=n {
        while let Some(&j) = stack.last() {
            if i == n || nums[j] < nums[i] {
                let height = nums[j];
                stack.pop();
                let width = if stack.is_empty() { i } else { i - stack.last().unwrap() - 1 };
                max_product = max(max_product, height * prefix_sum[i] - prefix_sum[stack.last().unwrap() + 1]);
            } else {
                break;
            }
        }
        stack.push(i);
    }

    (max_product % 1_000_000_007) as i32
}