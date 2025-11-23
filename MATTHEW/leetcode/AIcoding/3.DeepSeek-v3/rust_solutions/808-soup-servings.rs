use std::collections::HashMap;

impl Solution {
    pub fn soup_servings(n: i32) -> f64 {
        if n > 4800 {
            return 1.0;
        }
        let mut memo = HashMap::new();
        Self::dp(n, n, &mut memo)
    }

    fn dp(a: i32, b: i32, memo: &mut HashMap<(i32, i32), f64>) -> f64 {
        if let Some(&prob) = memo.get(&(a, b)) {
            return prob;
        }
        if a <= 0 && b <= 0 {
            return 0.5;
        }
        if a <= 0 {
            return 1.0;
        }
        if b <= 0 {
            return 0.0;
        }
        let prob = 0.25 * (
            Self::dp(a - 100, b, memo) +
            Self::dp(a - 75, b - 25, memo) +
            Self::dp(a - 50, b - 50, memo) +
            Self::dp(a - 25, b - 75, memo)
        );
        memo.insert((a, b), prob);
        prob
    }
}