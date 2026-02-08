impl Solution {
    pub fn days_between_dates(date1: String, date2: String) -> i32 {
        fn is_leap(year: i32) -> bool {
            (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
        }

        fn days_in_month(month: i32, year: i32) -> i32 {
            match month {
                1 | 3 | 5 | 7 | 8 | 10 | 12 => 31,
                4 | 6 | 9 | 11 => 30,
                2 => if is_leap(year) { 29 } else { 28 },
                _ => 0, // Should not happen with valid dates
            }
        }

        fn total_days_from_epoch(year: i32, month: i32, day: i32) -> i32 {
            let mut total_days = 0;

            // Add days for full years passed since 0001-01-01
            for y in 1..year {
                total_days += if is_leap(y) { 366 } else { 365 };
            }

            // Add days for full months passed in the current year
            for m in 1..month {
                total_days += days_in_month(m, year);
            }

            // Add days in the current month
            total_days += day;

            total_days
        }

        let parse_date = |date_str: String| -> (i32, i32, i32) {
            let parts: Vec<i32> = date_str
                .split('-')
                .map(|s| s.parse().unwrap())
                .collect();
            (parts[0], parts[1], parts[2])
        };

        let (y1, m1, d1) = parse_date(date1);
        let (y2, m2, d2) = parse_date(date2);

        let days1 = total_days_from_epoch(y1, m1, d1);
        let days2 = total_days_from_epoch(y2, m2, d2);

        (days1 - days2).abs()
    }
}