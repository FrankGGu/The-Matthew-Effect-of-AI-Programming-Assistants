impl Solution {
    pub fn days_between_dates(date1: String, date2: String) -> i32 {
        fn days_from_1971(date: String) -> i32 {
            let parts: Vec<i32> = date.split('-').map(|s| s.parse().unwrap()).collect();
            let (year, month, day) = (parts[0], parts[1], parts[2]);

            let mut days = 0;
            for y in 1971..year {
                days += if is_leap(y) { 366 } else { 365 };
            }

            for m in 1..month {
                days += match m {
                    1 | 3 | 5 | 7 | 8 | 10 | 12 => 31,
                    4 | 6 | 9 | 11 => 30,
                    2 => if is_leap(year) { 29 } else { 28 },
                    _ => 0,
                };
            }

            days + day
        }

        fn is_leap(year: i32) -> bool {
            (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
        }

        (days_from_1971(date1) - days_from_1971(date2)).abs()
    }
}