impl Solution {
    pub fn soup_servings(n: i32) -> f64 {
        if n > 4800 {
            return 1.0;
        }

        let n = n as usize;
        let mut memo = vec![vec![None; n + 1]; n + 1];

        fn solve(a: usize, b: usize, memo: &mut Vec<Vec<Option<f64>>>) -> f64 {
            if a == 0 && b == 0 {
                return 0.5;
            }
            if a == 0 {
                return 1.0;
            }
            if b == 0 {
                return 0.0;
            }

            if let Some(val) = memo[a][b] {
                return val;
            }

            let prob = 0.25 * (solve(a.saturating_sub(100), b, memo)
                + solve(a.saturating_sub(75), b.saturating_sub(25), memo)
                + solve(a.saturating_sub(50), b.saturating_sub(50), memo)
                + solve(a.saturating_sub(25), b.saturating_sub(75), memo));

            memo[a][b] = Some(prob);
            prob
        }

        solve(n, n, &mut memo)
    }
}