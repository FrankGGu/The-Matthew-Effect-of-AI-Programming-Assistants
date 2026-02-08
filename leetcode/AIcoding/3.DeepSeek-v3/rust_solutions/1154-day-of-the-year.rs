impl Solution {
    pub fn day_of_year(date: String) -> i32 {
        let parts: Vec<&str> = date.split('-').collect();
        let year: i32 = parts[0].parse().unwrap();
        let month: i32 = parts[1].parse().unwrap();
        let day: i32 = parts[2].parse().unwrap();

        let mut days_in_month = vec![31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (year % 400 == 0) || (year % 100 != 0 && year % 4 == 0) {
            days_in_month[1] = 29;
        }

        let mut day_of_year = 0;
        for i in 0..(month - 1) as usize {
            day_of_year += days_in_month[i];
        }
        day_of_year += day;

        day_of_year
    }
}