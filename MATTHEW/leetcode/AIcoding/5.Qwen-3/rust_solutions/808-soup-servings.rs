impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn soup_servings(n: i32) -> f64 {
        let n = n as f64;
        if n <= 1e-2 {
            return 1.0;
        }
        let mut memo = HashMap::new();
        Self::dp(n, n, &mut memo)
    }

    fn dp(a: f64, b: f64, memo: &mut HashMap<(f64, f64), f64>) -> f64 {
        if a <= 1e-2 && b <= 1e-2 {
            return 0.5;
        }
        if a <= 1e-2 {
            return 1.0;
        }
        if b <= 1e-2 {
            return 0.0;
        }
        if let Some(&val) = memo.get(&(a, b)) {
            return val;
        }
        let res = 0.25 * (Self::dp(a - 4.0, b - 0.0, memo)
            + Self::dp(a - 3.0, b - 1.0, memo)
            + Self::dp(a - 2.0, b - 2.0, memo)
            + Self::dp(a - 1.0, b - 3.0, memo));
        memo.insert((a, b), res);
        res
    }
}
}