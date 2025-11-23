impl Solution {
    pub fn day_of_year(date: String) -> i32 {
        let parts: Vec<&str> = date.split('-').collect();
        let year: i32 = parts[0].parse().unwrap();
        let month: i32 = parts[1].parse().unwrap();
        let day: i32 = parts[2].parse().unwrap();

        let mut days_in_month = vec![0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

        let is_leap_year = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

        if is_leap_year {
            days_in_month[2] = 29;
        }

        let mut day_count = 0;
        for i in 1..month {
            day_count += days_in_month[i as usize];
        }
        day_count += day;

        day_count
    }
}