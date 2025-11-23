impl Solution {
    pub fn max_jumps(arr: Vec<i32>, d: i32) -> i32 {
        let n = arr.len();
        let mut dp = vec![1; n];
        let mut indices: Vec<usize> = (0..n).collect();

        indices.sort_by_key(|&i| arr[i]);

        for &i in indices {
            for j in (1..=d).rev() {
                if i as i32 - j >= 0 && arr[i] > arr[i - j as usize] {
                    dp[i] = dp[i].max(dp[i - j as usize] + 1);
                }
                if i + j < n && arr[i] > arr[i + j as usize] {
                    dp[i] = dp[i].max(dp[i + j as usize] + 1);
                }
            }
        }

        *dp.iter().max().unwrap()
    }
}