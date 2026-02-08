impl Solution {
    pub fn max_jumps(arr: Vec<i32>, d: i32) -> i32 {
        let n = arr.len();
        let mut dp = vec![1; n];
        let mut indices: Vec<usize> = (0..n).collect();
        indices.sort_by_key(|&i| arr[i]);

        for &i in &indices {
            for j in (i as i32 - d).max(0) as usize..i {
                if arr[j] < arr[i] {
                    dp[i] = dp[i].max(dp[j] + 1);
                } else {
                    break;
                }
            }

            for j in i + 1..(i as i32 + d + 1).min(n as i32) as usize {
                if arr[j] < arr[i] {
                    dp[i] = dp[i].max(dp[j] + 1);
                } else {
                    break;
                }
            }
        }

        *dp.iter().max().unwrap()
    }
}