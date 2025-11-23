impl Solution {
    pub fn min_operations(s: String, k: i32) -> i32 {
        let n = s.len();
        let k = k as usize;
        let mut dp = vec![0; k];

        for i in 0..n {
            let idx = i % k;
            dp[idx] += 1;
        }

        let mut operations = 0;
        for j in 0..k {
            let count = dp[j];
            let need = (n / k + if j < n % k { 1 } else { 0 }) as i32;
            operations += count - need;
        }

        operations
    }
}