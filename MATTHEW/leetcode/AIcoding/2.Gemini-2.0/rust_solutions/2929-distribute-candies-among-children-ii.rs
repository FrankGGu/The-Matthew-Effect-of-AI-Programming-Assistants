impl Solution {
    pub fn distribute_candies(n: i64, limit: i64) -> i64 {
        let mut ans = 0;
        for i in 0..=limit.min(n) {
            let rem = n - i;
            let min_possible = rem.max(0) - limit;
            let count = limit.min(rem) - min_possible + 1;
            if count > 0 {
                ans += count;
            }
        }
        ans
    }
}