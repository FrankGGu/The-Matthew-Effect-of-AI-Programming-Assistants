impl Solution {
    pub fn total_money(n: i32) -> i32 {
        let mut total_money = 0;
        let mut current_week_day = 0; // 0 for Monday, 6 for Sunday
        let mut current_week_start_money = 1; // Money for Monday of the current week

        for _day_idx in 0..n {
            total_money += current_week_start_money + current_week_day;
            current_week_day += 1;

            if current_week_day == 7 {
                current_week_day = 0;
                current_week_start_money += 1;
            }
        }
        total_money
    }
}