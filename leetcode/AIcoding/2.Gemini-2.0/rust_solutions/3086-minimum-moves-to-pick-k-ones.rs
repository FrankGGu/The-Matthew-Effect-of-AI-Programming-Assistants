impl Solution {
    pub fn min_moves(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let ones: Vec<usize> = nums.iter().enumerate().filter(|(_, &x)| x == 1).map(|(i, _)| i).collect();
        let n = ones.len();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + ones[i] as i64;
        }

        let mut ans = i64::MAX;
        for i in 0..=n - k {
            let mid = i + k / 2;
            let median = ones[mid] as i64;
            let left_count = k / 2;
            let right_count = k - k / 2 - 1;

            let left_sum = prefix_sum[mid] - prefix_sum[i];
            let right_sum = prefix_sum[i + k] - prefix_sum[mid + 1];

            let moves = (median * left_count as i64 - left_sum) + (right_sum - median * right_count as i64);
            ans = ans.min(moves);
        }

        (ans - (k as i64 / 2) * ((k as i64 / 2) + 1) / 2 - ((k as i64 - 1 - k as i64 / 2) * (k as i64 - k as i64 / 2) / 2)) as i32
    }
}