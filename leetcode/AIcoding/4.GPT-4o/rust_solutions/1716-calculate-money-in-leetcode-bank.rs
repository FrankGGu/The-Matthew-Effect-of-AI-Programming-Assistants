impl Solution {
    pub fn total_money(n: i32) -> i32 {
        let weeks = n / 7;
        let days = n % 7;
        let total = weeks * (28 + weeks * 7) / 2 + days * (weeks + 1) + days * (days - 1) / 2;
        total
    }
}