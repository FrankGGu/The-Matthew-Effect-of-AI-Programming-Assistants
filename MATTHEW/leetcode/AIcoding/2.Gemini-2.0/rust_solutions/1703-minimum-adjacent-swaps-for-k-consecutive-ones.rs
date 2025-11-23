impl Solution {
    pub fn min_moves(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let ones: Vec<usize> = nums.iter().enumerate().filter(|&(_, &x)| x == 1).map(|(i, _)| i).collect();
        let n = ones.len();
        if n < k {
            return 0;
        }

        let mut medians: Vec<i64> = Vec::with_capacity(n - k + 1);
        for i in 0..=n - k {
            medians.push(ones[i + k / 2] as i64);
        }

        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + ones[i] as i64;
        }

        let mut ans = i64::MAX;
        for i in 0..=n - k {
            let median = medians[i];
            let left_count = k / 2;
            let right_count = k - left_count - (k % 2);

            let left_sum = prefix_sum[i + left_count + 1] - prefix_sum[i];
            let right_sum = prefix_sum[i + k] - prefix_sum[i + left_count + 1];

            let left_moves = median * left_count as i64 - left_sum;
            let right_moves = right_sum - median * right_count as i64;

            let total_moves = left_moves + right_moves;

            let base_moves = (-(left_count as i64) * ((left_count as i64) - 1) / 2) - ((right_count as i64) * ((right_count as i64) + 1) / 2);

            ans = ans.min(total_moves + base_moves);
        }

        ans as i32
    }
}