use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn min_days(n: i32) -> i32 {
        let mut memo: HashMap<i32, i32> = HashMap::new();
        Self::solve(n, &mut memo)
    }

    fn solve(n: i32, memo: &mut HashMap<i32, i32>) -> i32 {
        if n <= 1 {
            return n;
        }
        if let Some(&days) = memo.get(&n) {
            return days;
        }

        let mut res = (n % 2) + 1 + Self::solve(n / 2, memo);
        res = res.min((n % 3) + 1 + Self::solve(n / 3, memo));

        memo.insert(n, res);
        res
    }
}