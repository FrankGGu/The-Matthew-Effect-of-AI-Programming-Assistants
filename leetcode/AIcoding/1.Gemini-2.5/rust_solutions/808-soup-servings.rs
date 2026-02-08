struct Solution;

impl Solution {
    pub fn soup_servings(n: i32) -> f64 {
        // If n is large enough, the probability approaches 1.0 due to A decreasing faster on average.
        // A common threshold for n where the probability is effectively 1.0 (within typical float precision)
        // is around 4800. For n values beyond this, the difference from 1.0 is negligible.
        if n >= 4800 {
            return 1.0;
        }

        // Convert n to units of 25ml. We use ceil(n / 25.0).
        // For example, if n=1, we need 1 unit. If n=25, 1 unit. If n=26, 2 units.
        let m = (n + 24) / 25;

        // memo[i][j] stores the probability of the desired outcome when i units of A and j units of B are remaining.
        // The maximum value for i and j is m.
        // Initialize with -1.0 to indicate uncomputed states.
        let mut memo = vec![vec![-1.0; (m + 1) as usize]; (m + 1) as usize];

        Self::solve(m, m, &mut memo)
    }

    fn solve(a: i32, b: i32, memo: &mut Vec<Vec<f64>>) -> f64 {
        // Base cases:
        // 1. Both soups run out (A <= 0 and B <= 0). Probability is 0.5.
        if a <= 0 && b <= 0 {
            return 0.5;
        }
        // 2. Soup A runs out, but Soup B still has some (A <= 0 and B > 0). Probability is 1.0.
        if a <= 0 {
            return 1.0;
        }
        // 3. Soup B runs out, but Soup A still has some (A > 0 and B <= 0). Probability is 0.0.
        if b <= 0 {
            return 0.0;
        }

        // Check memoization table
        if memo[a as usize][b as usize] != -1.0 {
            return memo[a as usize][b as usize];
        }

        // Recursive step:
        // Each of the four serving operations has a 25% probability.
        // The operations are:
        // 1. Serve 100ml from A (4 units)
        // 2. Serve 75ml from A (3 units), 25ml from B (1 unit)
        // 3. Serve 50ml from A (2 units), 50ml from B (2 units)
        // 4. Serve 25ml from A (1 unit), 75ml from B (3 units)
        let prob = 0.25 * (
            Self::solve(a - 4, b, memo) +
            Self::solve(a - 3, b - 1, memo) +
            Self::solve(a - 2, b - 2, memo) +
            Self::solve(a - 1, b - 3, memo)
        );

        // Store the computed probability in the memoization table
        memo[a as usize][b as usize] = prob;
        prob
    }
}