impl Solution {
    pub fn total_money(n: i32) -> i32 {
        let weeks = n / 7;
        let days = n % 7;
        let week_sum = (1 + weeks + 1) * weeks / 2 * 7;
        let day_sum = (weeks + 1 + weeks + days) * days / 2;
        week_sum + day_sum
    }
}