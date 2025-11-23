pub fn longest_subsequence(arr: Vec<i32>, target: i32) -> i32 {
    let n = arr.len();
    let mut dp = vec![0; target as usize + 1];

    for &num in arr.iter() {
        for j in (num..=target).rev() {
            dp[j as usize] = dp[j as usize].max(dp[(j - num) as usize] + 1);
        }
    }

    dp[target as usize]
}