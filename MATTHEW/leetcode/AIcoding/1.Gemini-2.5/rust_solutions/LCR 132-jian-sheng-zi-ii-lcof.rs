impl Solution {
    pub fn minimum_total_cost(bamboo_height: Vec<i32>, cost: Vec<i32>) -> i64 {
        const MAX_H: usize = 1000;
        let mut dp: Vec<i64> = vec![0; MAX_H + 1];

        // Base case: The cost to reduce a bamboo of height 1 to 1 is 0.
        dp[1] = 0;

        // Calculate the minimum cost to reduce each height `i` to 1.
        // For a bamboo of height `i`, the only allowed cut operation is to reduce it
        // to `i/2` (integer division), incurring a cost of `cost[i]`.
        // Therefore, the minimum cost to reduce `i` to 1 is the cost of cutting `i` to `i/2`
        // plus the minimum cost to reduce `i/2` to 1.
        for i in 2..=MAX_H {
            dp[i] = cost[i] as i64 + dp[i / 2];
        }

        // Calculate the total minimum cost for all bamboos.
        let mut total_cost: i64 = 0;
        for h in bamboo_height {
            total_cost += dp[h as usize];
        }

        total_cost
    }
}