use std::collections::HashMap;

impl Solution {
    pub fn min_days(n: i32) -> i32 {
        let mut memo: HashMap<i32, i32> = HashMap::new();

        fn solve(n: i32, memo: &mut HashMap<i32, i32>) -> i32 {
            if n <= 1 {
                return n;
            }

            if let Some(&days) = memo.get(&n) {
                return days;
            }

            let days = 1 + std::cmp::min(
                n % 2 + solve(n / 2, memo),
                n % 3 + solve(n / 3, memo)
            );

            memo.insert(n, days);
            days
        }

        solve(n, &mut memo)
    }
}