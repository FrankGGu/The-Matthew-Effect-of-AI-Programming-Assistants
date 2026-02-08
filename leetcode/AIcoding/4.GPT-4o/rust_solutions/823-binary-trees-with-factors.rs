impl Solution {
    pub fn num_factored_binary_trees(arr: Vec<i32>) -> i32 {
        let mod_val = 1_000_000_007;
        let mut arr = arr;
        arr.sort();
        let mut dp = vec![1; arr.len()];
        let index: std::collections::HashMap<_, _> = arr.iter().enumerate().map(|(i, &v)| (v, i)).collect();

        for i in 0..arr.len() {
            for j in 0..i {
                if arr[i] % arr[j] == 0 {
                    if let Some(&k) = index.get(&(arr[i] / arr[j])) {
                        dp[i] = (dp[i] + dp[j] * dp[k]) % mod_val;
                    }
                }
            }
        }

        dp.iter().sum::<i32>() % mod_val
    }
}