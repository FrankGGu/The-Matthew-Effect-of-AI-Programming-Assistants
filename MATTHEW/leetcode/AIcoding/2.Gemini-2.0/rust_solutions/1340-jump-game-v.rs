impl Solution {
    pub fn max_jumps(arr: Vec<i32>, d: i32) -> i32 {
        let n = arr.len();
        let mut dp = vec![0; n];
        let mut indices: Vec<usize> = (0..n).collect();
        indices.sort_by_key(|&i| arr[i]);

        for &i in &indices {
            let mut max_reach = 1;

            for j in (i as i32 - d) as usize..=i - 1 {
                if j >= 0 && j < n && arr[j] < arr[i] {
                    max_reach = max_reach.max(dp[j] + 1);
                } else {
                    break;
                }
            }

            for j in i + 1..=i + d as usize {
                if j < n && arr[j] < arr[i] {
                    max_reach = max_reach.max(dp[j] + 1);
                } else {
                    break;
                }
            }
            dp[i] = max_reach;
        }

        *dp.iter().max().unwrap()
    }
}