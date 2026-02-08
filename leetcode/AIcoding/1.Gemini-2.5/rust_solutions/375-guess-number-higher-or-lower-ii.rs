impl Solution {
    pub fn get_money_amount(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![0; n + 1]; n + 1];

        for len in 1..n { // len represents the length of the range (j - i)
            for i in 1..=n - len {
                let j = i + len;
                let mut min_cost = i32::MAX;

                for k in i..=j {
                    // If we pick k, we pay k.
                    // If the actual number is less than k, we need to solve for the range [i, k-1].
                    // If the actual number is greater than k, we need to solve for the range [k+1, j].
                    // To guarantee a win, we must consider the worst-case scenario (max of the two subproblems).
                    let cost_if_lower = if k > i { dp[i][k - 1] } else { 0 };
                    let cost_if_higher = if k < j { dp[k + 1][j] } else { 0 };

                    min_cost = min_cost.min(k as i32 + cost_if_lower.max(cost_if_higher));
                }
                dp[i][j] = min_cost;
            }
        }

        dp[1][n]
    }
}