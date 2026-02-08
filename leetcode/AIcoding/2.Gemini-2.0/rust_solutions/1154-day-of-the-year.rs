impl Solution {
    pub fn day_of_the_year(date: String) -> i32 {
        let parts: Vec<&str> = date.split('-').collect();
        let year: i32 = parts[0].parse().unwrap();
        let month: i32 = parts[1].parse().unwrap();
        let day: i32 = parts[2].parse().unwrap();

        let days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

        let mut total_days = 0;
        for i in 1..month {
            total_days += days_in_month[i as usize];
        }

        total_days += day;

        if Self::is_leap_year(year) && month > 2 {
            total_days += 1;
        }

        total_days
    }

    fn is_leap_year(year: i32) -> bool {
        (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
    }
}