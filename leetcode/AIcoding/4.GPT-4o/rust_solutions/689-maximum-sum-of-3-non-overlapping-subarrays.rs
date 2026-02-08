pub fn max_sum_of_three_subarrays(nums: Vec<i32>, k: usize) -> Vec<usize> {
    let n = nums.len();
    let mut prefix_sum = vec![0; n + 1];
    for i in 0..n {
        prefix_sum[i + 1] = prefix_sum[i] + nums[i];
    }

    let mut sum = vec![0; n + 1];
    for i in k..=n {
        sum[i] = prefix_sum[i] - prefix_sum[i - k];
    }

    let mut left_max = vec![0; n + 1];
    let mut right_max = vec![0; n + 1];

    let mut max_index = 0;
    for i in k..=n {
        if sum[i] > sum[max_index] {
            max_index = i;
        }
        left_max[i] = max_index;
    }

    max_index = n;
    for i in (k..=n).rev() {
        if sum[i] >= sum[max_index] {
            max_index = i;
        }
        right_max[i] = max_index;
    }

    let mut result = vec![0; 3];
    let mut max_total = 0;

    for i in k..=n - 2 * k {
        let left = left_max[i];
        let right = right_max[i + k];
        let total = sum[left] + sum[i] + sum[right];
        if total > max_total {
            max_total = total;
            result[0] = (left - k) as usize;
            result[1] = (i - k) as usize;
            result[2] = (right - k) as usize;
        }
    }

    result
}