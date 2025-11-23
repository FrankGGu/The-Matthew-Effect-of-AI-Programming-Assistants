impl Solution {
    pub fn total_money(n: i32) -> i32 {
        let weeks = n / 7;
        let days = n % 7;
        let mut total = 0;

        total += 28 * weeks;
        total += 7 * weeks * (weeks - 1) / 2;

        total += days * (days + 1) / 2;
        total += days * weeks;

        total
    }
}