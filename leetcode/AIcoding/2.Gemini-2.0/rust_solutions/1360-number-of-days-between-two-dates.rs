impl Solution {
    pub fn days_between_dates(date1: String, date2: String) -> i32 {
        fn days_from_epoch(date: &str) -> i32 {
            let parts: Vec<i32> = date.split('-').map(|s| s.parse().unwrap()).collect();
            let year = parts[0];
            let month = parts[1];
            let day = parts[2];

            let mut days = 0;
            for y in 1971..year {
                if (y % 4 == 0 && y % 100 != 0) || y % 400 == 0 {
                    days += 366;
                } else {
                    days += 365;
                }
            }

            let days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            for m in 1..month {
                let mut d = days_in_month[(m - 1) as usize];
                if m == 2 && ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
                    d += 1;
                }
                days += d;
            }

            days += day;
            days
        }

        let days1 = days_from_epoch(&date1);
        let days2 = days_from_epoch(&date2);

        (days1 - days2).abs()
    }
}