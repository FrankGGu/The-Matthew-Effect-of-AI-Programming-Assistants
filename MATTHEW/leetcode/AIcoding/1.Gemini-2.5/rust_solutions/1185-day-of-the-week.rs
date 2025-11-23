impl Solution {
    fn is_leap(y: i32) -> bool {
        (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0)
    }

    pub fn day_of_the_week(day: i32, month: i32, year: i32) -> String {
        let week_days = vec![
            "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday",
        ];
        let days_in_month_arr = vec![0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

        let mut total_days = 0;

        for y in 1970..year {
            total_days += if Self::is_leap(y) { 366 } else { 365 };
        }

        for m in 1..month {
            total_days += days_in_month_arr[m as usize];
            if m == 2 && Self::is_leap(year) {
                total_days += 1;
            }
        }

        total_days += day;

        let index = (total_days + 3) % 7;
        week_days[index as usize].to_string()
    }
}