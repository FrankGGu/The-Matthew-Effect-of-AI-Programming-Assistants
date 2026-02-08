impl Solution {
    pub fn longest_arith_seq_length(A: Vec<i32>) -> i32 {
        let n = A.len();
        let mut dp = vec![std::collections::HashMap::new(); n];
        let mut max_length = 0;

        for i in 0..n {
            for j in 0..i {
                let diff = A[i] - A[j];
                let length = dp[j].get(&diff).unwrap_or(&1) + 1;
                dp[i].insert(diff, length);
                max_length = max_length.max(length);
            }
        }

        max_length
    }
}